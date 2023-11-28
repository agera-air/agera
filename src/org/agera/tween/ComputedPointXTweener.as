package org.agera.tween {
    import flash.geom.*;

    /**
     * @private
     */
    internal final class ComputedPointXTweener extends Tweener {
        private var propertyName: String;
        private var finalValue: Number;

        public function ComputedPointXTweener(easing: String, propertyName: String, finalValue: Number) {
            super(easing);
            this.propertyName = propertyName;
            this.finalValue = finalValue;
        }

        override protected function exec(current1: *): Boolean {
            // exec()
        }
    }
}