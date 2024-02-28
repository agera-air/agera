package agera.ui {
    import flash.display.*;
    import agera.util.*;

    /**
     * @private
     */
    internal final class UIControl_Hierarchy {
        public static function firstFocusTarget(object: DisplayObject): DisplayObject {
            if (DisplayObject_focusable(object)) {
                return object;
            }
            if (object is DisplayObjectContainer) {
                const container: DisplayObjectContainer = DisplayObjectContainer(object);
                for (var i: int = 0; i < container.numChildren; ++i) {
                    const first: DisplayObject = firstFocusTarget(container.getChildAt(i));
                    if (first != null) {
                        return first;
                    }
                }
            }
            return null;
        }

        public static function lastFocusTarget(object: DisplayObject): DisplayObject {
            if (DisplayObject_focusable(object)) {
                return object;
            }
            if (object is DisplayObjectContainer) {
                const container: DisplayObjectContainer = DisplayObjectContainer(object);
                for (var i: int = container.numChildren - 1; i > -1; --i) {
                    const last: DisplayObject = lastFocusTarget(container.getChildAt(i));
                    if (last != null) {
                        return last;
                    }
                }
            }
            return null;
        }

        public static function nextFocusTarget(fromObject: DisplayObject): DisplayObject {
            var parent: DisplayObjectContainer = fromObject.parent;
            if (parent == null) {
                return firstFocusTarget(fromObject.stage.root);
            }
            for (var i: int = parent.getChildIndex(fromObject) + 1; i < parent.numChildren; ++i) {
                var next: DisplayObject = firstFocusTarget(parent.getChildAt(i));
                if (next != null) {
                    return next;
                }
            }
            return nextFocusTarget(parent);
        }

        public static function previousFocusTarget(fromObject: DisplayObject): DisplayObject {
            var parent: DisplayObjectContainer = fromObject.parent;
            if (parent == null) {
                return lastFocusTarget(fromObject.stage.root);
            }
            for (var i: int = parent.getChildIndex(fromObject) - 1; i > -1; --i) {
                var previous: DisplayObject = lastFocusTarget(parent.getChildAt(i));
                if (previous != null) {
                    return previous;
                }
            }
            return previousFocusTarget(parent);
        }

        public static function neighborExpandControls(fromControl: UIControl, output: Vector.<UIControl>): void {
            output.length = 0;
            var container: UIControl = fromControl.parent as UIControl;
            if (container == null) {
                return;
            }
            var fromControlIndex: int = container.getChildIndex(fromControl);
            var i: int = 0;
            var j: int = container.numChildren;
            var object: DisplayObject = null;
            for (i = fromControlIndex - 1; i > -1; --i) {
                object = container.getChildAt(i);
                if (object is UIControl && UIControl(object).layoutHorizontalSizing.expand) {
                    output.unshift(UIControl(object));
                }
            }
            for (i = fromControlIndex; i < j; ++i) {
                object = container.getChildAt(i);
                if (object is UIControl && UIControl(object).layoutVerticalSizing.expand) {
                    output.push(UIControl(object));
                }
            }
        }
    }
}