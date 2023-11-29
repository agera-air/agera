package org.agera.tween {
    /**
     * @private
     */
    internal final class NumberTweener extends Tweener {
        private var finalValue: Number;

        public function NumberTweener(easingFunction: Function, object: Object, propertyPath: String, finalValue: Number) {
            super(easingFunction, object, propertyPath);
            this.finalValue = finalValue;
        }

        override protected function exec(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            // exec()
        }
    }
}