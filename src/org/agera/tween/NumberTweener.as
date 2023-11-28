package org.agera.tween {
    /**
     * @private
     */
    internal final class NumberTweener extends Tweener {
        private var finalValue: Number;

        public function NumberTweener(transitionType: String, easeType: String, finalValue: Number) {
            super(transitionType, easeType);
            this.finalValue = finalValue;
        }

        override protected function exec(current1: *): Boolean {
            // exec()
        }
    }
}