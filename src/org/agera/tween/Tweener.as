package org.agera.tween {
    import flash.geom.*;

    /**
     * @private
     */
    internal class Tweener {
        protected var transitionType: String;
        protected var easeType: String;

        public function Tweener(transitionType: String, easeType: String) {
            this.transitionType = transitionType;
            this.easeType = easeType;
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