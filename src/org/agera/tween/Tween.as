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
     * new Tween(object, "propertyPath", value, seconds, easing);
     * </listing>
     * </p>
     */
    public final class Tween {
        /**
         * @param object Any object.
         * @param propertyPath Property path consisting of a <code>DisplayPath</code> with a trailing property name segment.
         * @param value Final value.
         * @param seconds Duration in seconds.
         * @param easing One of the constants defined in the <code>Easing</code> class.
         */
        public function Tween(object: Object, propertyPath: String, value: *, seconds: Number, easing: String = Easing.LINEAR) {
            const self: Tween = this;

            var pointNameToCompute: String = null;

            // Find object
            var pathSegments: Array = (propertyPath || "").split("/");
            var propertyName: String = pathSegments.pop();
            assert(propertyName != null, "Tween property name must be specified.");
            if (pathSegments.length != 0) {
                var object1: DisplayObject = object as DisplayObject;
                assert(object1 != null, "Tween object must be a DisplayObject when given a DisplayObject path.");
                object1 = new DisplayPath(pathSegments.join("/")).resolve(object1);
                if (object1 == null) {
                    pointNameToCompute = pathSegments.pop();
                    object1 = new DisplayPath(pathSegments.join("/")).resolve(object1);
                    var computedPoint: Point = object1 === null || ["x", "y"].indexOf(propertyName) == -1 ? null : object1[pointNameToCompute];
                    if (computedPoint == null) {
                        object1 = null;
                    }
                }
                assert(object1 != null, "Tween node path '" + propertyPath + "' not found.");
                object = object1;
            }

            // Create Tweener object
            var tweener: Tweener = null;
            if (pointNameToCompute != null) {
                assert(value is Number, "Final value must be a Number value.");
                tweener = propertyName == "y" ? new ComputedPointYTweener(easing, pointNameToCompute, Number(value)) : new ComputedPointXTweener(easing, pointNameToCompute, Number(value));
            } else if (object[propertyName] is Point) {
                assert(value is Point, "Final value must be a Point object.");
                tweener = new PointTweener(easing, Point(value));
            } else {
                assert(object[propertyName] is Number, "Property must be of either Point or Number data type.");
                assert(value is Number, "Final value must be a Number value.");
                tweener = new NumberTweener(easing, Number(value));
            }

            // Execute the tweener
            toDo();
        }
    }
}