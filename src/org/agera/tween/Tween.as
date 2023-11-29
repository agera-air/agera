package org.agera.tween {
    import flash.display.*;
    import flash.geom.*;
    import flash.events.*;
    import flash.utils.*;
    import org.agera.events.*;
    import org.agera.util.*;

    // This source code is based on the Caurina Tweener implementation.
    // https://github.com/zeh/tweener/blob/master/as3/caurina/transitions/Tweener.as

    /**
     * Dispatched when the tweener finishes execution.
     *
     * @eventType org.agera.events.AgeraEvent.FINISHED
     */
    [Event(name = "finished", type = "org.agera.events.AgeraEvent")]
    /**
     * A tweener object for executing property transitions
     * from a value to another value.
     * 
     * <p><b>Property paths</b></p>
     * 
     * <p>Property paths consist of a path (as specified by the <code>PropertyPath</code> class). Here are a few examples:
     * 
     * <listing version="3.0">
     * "y"
     * "somePoint/x"
     * </listing>
     * </p>
     * 
     * <p><b>Points</b></p>
     * 
     * <p>The Agera tweener supports tweening <code>Number</code> and <code>flash.geom.Point</code> property values.</p>
     * 
     * <p><b>Syntax</b></p>
     * 
     * <p>
     * <listing version="3.0">
     * import org.agera.tween.*;
     * 
     * new Tween(object, "propertyPath", value, seconds);
     * new Tween(object, "propertyPath", value, seconds, easing);
     * new Tween(object, "propertyPath", value, seconds, easing, otherOptions);
     * 
     * tween.exec();
     * </listing>
     * </p>
     */
    public final class Tween {
        private static var mController: MovieClip = null;
        private static var mEngineExists: Boolean = false;
        private static var mTweeners: Vector.<Tweener>;
        private static var mTimeScale: Number = 1;
        private static var mCurrentTime: Number;
        private static var mCurrentTimeFrame: Number;

        private var mTweener: Tweener;
        private var mTime: Number;
        private var mDelay: Number;

        /**
         * The <code>Tween()</code> constructor. It does not immediately execute the tweener;
         * you must invoke its <code>exec()</code> method to execute the tweener.
         * 
         * <p><b>Additional options</b></p>
         * 
         * <p>The following additional options are supported:
         * <ul>
         *   <li><code>delay</code> — Delay time (defaults to 0)</li>
         *   <li><code>useFrames</code> — Whether to use frames or not as the time unit</li>
         *   <li><code>rounded</code></li>
         *   <li><code>transition</code> — Transition parameters supporting the properties <code>{period: Number, amplitude: Number}</code></li>
         * </ul>
         * </p>
         *
         * @param object Any object.
         * @param propertyPath Property path consisting of a <code>PropertyPath</code>.
         * @param value Final value.
         * @param time Duration in seconds or frames.
         * @param easing One of the constants defined in the <code>Easing</code> class.
         * @param options Additional options object.
         */
        public function Tween(object: Object, propertyPath: String, value: *, time: Number, easing: String = Easing.LINEAR, options: * = undefined) {
            const self: Tween = this;

            assert(object != null, "Object must be specified.");

            // Verify options
            assert(options === undefined || typeof options === "object", "Malformed options argument");
            options ||= {};
            assert(options.delay === undefined || options.delay is Number, "Malformed delay option");
            assert(options.useFrames === undefined || options.useFrames is Boolean, "Malformed useFrames option");
            assert(options.rounded === undefined || options.rounded is Boolean, "Malformed rounded option");
            assert(options.transition === undefined || typeof options.transition === "options", "Malformed transition option");

            // options.delay
            const delay: Number = options.delay === undefined ? 0 : Number(options.delay);

            // options.useFrames
            const useFrames: Boolean = Boolean(options.useFrames);

            // options.rounded
            const rounded: Boolean = Boolean(options.rounded);

            // options.transition
            const transition: Object = options.transition as Object;

            var propertyPreCheck: * = PropertyPath.get(object, propertyPath);

            // Easing function
            const easingFunction: Function = Equations.map[easing] as Function;
            assert(easingFunction != null, "Unrecognized easing constant: '" + easing + "'.");

            // Create Tweener object
            assert(propertyPreCheck is Number, "Property must be of Number data type.");
            assert(value is Number, "Final value must be a Number value.");
            var tweener: Tweener = new Tweener(easingFunction, object, propertyPath, Number(value));

            tweener.timeStart = mCurrentTimeFrame + (delay / mTimeScale);
            tweener.timeComplete = mCurrentTimeFrame + ((delay + time) / mTimeScale);
            tweener.useFrames = useFrames;
            tweener.rounded = rounded;
            tweener.transition = transition;

            this.mTweener = tweener;
            this.mTime = time;
            this.mDelay = delay;
        }
        
        public function get executing(): Boolean {
            return mTweeners.indexOf(this.mTweener) != -1;
        }

        /**
         * Executes the tweener.
         */
        public function exec(): void {
            if (this.executing) {
                return;
            }

            mTweeners.push(this.mTweener);

            // Immediate update and removal if it is an immediate tween — if not deleted,
            // it executes at the end of this frame execution.
            if (mTime == 0 && mDelay == 0) {
                var i: int = mTweeners.length - 1;
                updateTweenByIndex(i);
                removeTweenByIndex(i);
            }
        }

        /**
         * Stops the tweener.
         */
        public function stop(): void {
            if (!this.executing) {
                return;
            }
            toDo();
        }

        private static function startEngine(): void {
            mEngineExists = true;
            mTweeners = new <Tweener> [];

            mController = new MovieClip();
            mController.addEventListener(Event.ENTER_FRAME, onEnterFrame);

            mCurrentTimeFrame = 0;
            updateTime();
        }
        
        private static function stopEngine(): void {
            mEngineExists = false;
            mTweeners = null;
            mCurrentTime = 0;
            mCurrentTimeFrame = 0;
            mController.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            mController = null;
        }

        /**
         * Updates the time to enforce time grid-based updates.
         */
        private static function updateTime(): void {
            mCurrentTime = getTimer();
        }

        /**
         * Updates the current frame count.
         */
        private static function updateFrame(): void {
            mCurrentTimeFrame++;
        }

        /**
         * For every frame, updates all existing tweeners.
         */
        private static function onEnterFrame(event: Event): void {
            updateTime();
            updateFrame();
            var hasUpdated: Boolean = false;
            hasUpdated = updateTweens();
            if (!hasUpdated) {
                // Stop the engine as there is no tweening to update or wait
                stopEngine();
            }
        }

        /**
         * The global time scale applied to all tweeners. Assigning this property a value of 1
         * produces no effect; assigning a value of 0.5 slows down the existing
         * tweens; assigning a value of 2 fast-forwards the existing
         * tweens.
         */
        public static function get timeScale(): Number {
            return mTimeScale;
        }

        public static function set timeScale(time: Number): void {
            time = isNaN(time) ? 1 : time;
            time = time < 0.00001 ? 0.00001 : time;
            if (time != mTimeScale) {
                if (mTweeners != null) {
                    // Multiplies all existing tween times accordingly
                    for each (var tweener: Tweener in mTweeners) {
                        var cTime: Number = getCurrentTweeningTime(tweener);
                        tweener.timeStart = cTime - ((cTime - tweener.timeStart) * mTimeScale / time);
                        tweener.timeComplete = cTime - ((cTime - tweener.timeComplete) * mTimeScale / time);
                        if (tweener.timePaused != null) {
                            tweener.timePaused = cTime - ((cTime - Number(tweener.timePaused)) * mTimeScale / time);
                        }
                    }
                }
                // Sets the new timescale value (for new tweenigs)
                mTimeScale = time;
            }
        }
    }
}