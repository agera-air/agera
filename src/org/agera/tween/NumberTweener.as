package org.agera.tween {
    /**
     * @private
     */
    internal final class NumberTweener extends Tweener {
        private var finalValue: Number;

        public function NumberTweener(easing: String, finalValue: Number) {
            super(easing);
            this.finalValue = finalValue;
        }

        override protected function exec(current1: *): Boolean {
            // exec()
        }
    }
}