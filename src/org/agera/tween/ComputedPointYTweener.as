package org.agera.tween {
    import flash.geom.*;

    /**
     * @private
     */
    internal final class ComputedPointYTweener extends Tweener {
        private var propertyName: String;
        private var finalValue: Number;

        public function ComputedPointYTweener(transitionType: String, easeType: String, propertyName: String, finalValue: Number) {
            super(transitionType, easeType);
            this.propertyName = propertyName;
            this.finalValue = finalValue;
        }

        override protected function exec(current1: *): Boolean {
            // exec()
        }
    }
}