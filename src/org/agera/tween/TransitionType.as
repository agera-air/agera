package org.agera.tween {
    /**
     * Represents a transition type for a <code>Tween</code> object.
     */
    public final class TransitionType {
        /**
         * Indicates a linear transition.
         */
        public static const LINEAR: String = "linear";
        /**
         * Indicates a sine function.
         */
        public static const SINE: String = "sine";
        /**
         * Indicates a quadratic (power of 2) function.
         */
        public static const QUADRATIC: String = "quadratic";
        /**
         * Indicates a cubic (power of 3) function.
         */
        public static const CUBIC: String = "cubic";
        /**
         * Indicates a quartic (power of 4) function.
         */
        public static const QUARTIC: String = "quartic";
        /**
         * Indicates a quintic (power of 5) function.
         */
        public static const QUINTIC: String = "quintic";
        /**
         * Indicates an elastic function.
         */
        public static const ELASTIC: String = "elastic";
        /**
         * Indicates an interpolation with bouncing at the end.
         */
        public static const BOUNCE: String = "bounce";
        /**
         * Indicates a back function.
         */
        public static const BACK: String = "back";
    }
}