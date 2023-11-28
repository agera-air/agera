package org.agera.tween {
    import flash.geom.*;

    /**
     * @private
     */
    internal class Tweener {
        protected var easing: String;

        public function Tweener(easing: String) {
            this.easing = easing;
        }

        /**
         * Executes the tweener and returns <code>true</code>
         * if it has finished execution.
         */
        protected function exec(current1: *): Boolean {
            return true;
        }
    }
}