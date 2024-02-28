package agera.ui {
    public final class FocusMode {
        /**
         * Indicates that a control cannot be focused.
         */
        public static const NONE: FocusMode = new FocusMode();
        /**
         * Indicates that a control can be focused by
         * mouse, keyboard or gamepad.
         */
        public static const ALL: FocusMode = new FocusMode();
        /**
         * Indicates that a control can be focused by
         * mouse only.
         */
        public static const CLICK: FocusMode = new FocusMode();
    }
}