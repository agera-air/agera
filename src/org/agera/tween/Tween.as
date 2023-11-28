package org.agera.tween {
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    import org.agera.util.*;

    /**
     * A tweener object for executing property transitions
     * from a value to another value.
     * 
     * <p><b>Property paths</b></p>
     * 
     * <p>Property paths consist of a path as specified by the <code>DisplayPath</code> class), with
     * either one trailing segment identifying the property name or two trailing segments identifying
     * <code>x</code> or <code>y</code> from a <code>Point</code> property. Here are a few examples:
     * 
     * <listing version="3.0">
     * "y"
     * "myButton/minWidth"
     * "somePoint/x"
     * </listing>
     * </p>
     * 
     * <p><b>Points</b></p>
     * 
     * <p>The Agera tweener supports tweening <code>Number</code> and <code>flash.geom.Point</code> property values.</p>
     * 
     * <p>When specifying the property path, a <code>propertyName/x</code> or <code>propertyName/y</code> property path
     * where <code>propertyName</code> identifies a <code>Point</code> property, the Agera tweener updates the
     * <code>x</code> or <code>y</code> properties after computing the <code>propertyName</code> property.</p>
     * 
     * <p><b>Syntax</b></p>
     * 
     * The <code>Tweener()</code> constructor immediately executes the tweener:
     * 
     * <p>
     * <listing version="3.0">
     * import org.agera.tween.*;
     * 
     * new Tween(object, "propertyPath", value, seconds);
     * new Tween(object, "propertyPath", value, seconds, transitionType);
     * new Tween(object, "propertyPath", value, seconds, transitionType, easeType);
     * </listing>
     * </p>
     */
    public final class Tween {
        /**
         * @param object Any object.
         * @param propertyPath Property path consisting of a <code>DisplayPath</code> with a trailing property name segment.
         * @param value Final value.
         * @param seconds Duration in seconds.
         * @param transitionType One of the constants defined in <code>TransitionType</code>.
         * @param easeType One of the constants defined in <code>EaseType</code>.
         */
        public function Tween(object: Object, propertyPath: String, value: *, seconds: Number, transitionType: String = TransitionType.LINEAR, easeType: String = EaseType.IN_OUT) {
            const self: Tween = this;

            // Find object
            var pathSegments: Array = (propertyPath || "").split("/");
            var propertyName: String = pathSegments.pop();
            assert(propertyName != null, "Tween property name must be specified.");
            if (pathSegments.length != 0) {
                var object1: DisplayObject = object as DisplayObject;
                assert(object1 != null, "Tween object must be a DisplayObject when given a DisplayObject path.");
                object1 = new DisplayPath(pathSegments.join("/")).resolve(object1);
                assert(object1 != null, "Tween node path not found.");
                object = object1;
            }

            // Execute the tweener
            toDo();
        }
    }
}