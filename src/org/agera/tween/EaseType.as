package org.agera.tween {
    /**
     * Represents the ease type for a <code>Tween</code> object.
     */
    public final class EaseType {
        /**
         * The interpolation starts slowly and speeds up towards the end.
         */
        public static const IN: String = "in";
        /**
         * The interpolation starts quickly and slows down towards the end.
         */
        public static const OUT: String = "out";
        /**
         * A combination of <code>EaseType.IN</code> and <code>EaseType.OUT</code>.
         * The interpolation is slowest at both ends.
         */
        public static const IN_OUT: String = "inOut";
        /**
         * A combination of <code>EaseType.IN</code> and <code>EaseType.OUT</code>.
         * The interpolation is fastest at both ends.
         */
        public static const OUT_IN: String = "outIn";
    }
}