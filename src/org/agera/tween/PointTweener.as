package org.agera.tween {
    import flash.geom.*;

    /**
     * @private
     */
    internal final class PointTweener extends Tweener {
        private var finalValue: Point;

        public function PointTweener(transitionType: String, easeType: String, finalValue: Point) {
            super(transitionType, easeType);
            this.finalValue = finalValue;
        }

        override protected function exec(current1: *): Boolean {
            // exec()
        }
    }
}