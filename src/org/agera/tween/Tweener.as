package org.agera.tween {
    import flash.geom.*;

    /**
     * @private
     */
    internal final class Tweener {
        private var easingFunction: Function;
        private var object: Object;
        private var propertyPath: String;
        private var finalValue: Number;

        public var timeStart: Number = 0;
        public var timeComplete: Number = 0;
        public var timePaused: Object = null;
        public var useFrames: Boolean = false;
        public var rounded: Boolean = false;
        public var isPaused: Boolean = false;

        /**
         * Transition parameters.
         */
        public var transition: Object = null;

        public function Tweener(easingFunction: Function, object: Object, propertyPath: String, finalValue: Number) {
            this.easingFunction = easingFunction;
            this.object = object;
            this.propertyPath = propertyPath;
            this.finalValue = finalValue;
        }

        /**
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public function exec(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return 0;
        }
    }
}