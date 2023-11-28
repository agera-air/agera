package org.agera.tween {
    import flash.geom.*;

    /**
     * @private
     */
    internal final class PointTweener extends Tweener {
        private var finalValue: Point;

        public function PointTweener(easing: String, finalValue: Point) {
            super(easing);
            this.finalValue = finalValue;
        }

        override protected function exec(current1: *): Boolean {
            // exec()
        }
    }
}