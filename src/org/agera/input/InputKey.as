package org.agera.input {
    import flash.events.KeyboardEvent;

    /**
     * Represents a keyboard key. This structure class additionally
     * supports combining modifier keys such as <code>Ctrl</code> and <code>Shift</code>.
     */
    public final class InputKey {
        public var keyCode: Number;
        public var ctrlKey: Boolean = false;
        public var shiftKey: Boolean = false;
        public var altKey: Boolean = false;
        public var functionKey: Boolean = false;

        public function InputKey(keyCode: Number) {
            this.keyCode = keyCode;
        }

        public function setCtrlKey(value: Boolean): InputKey {
            this.ctrlKey = value;
            return this;
        }

        public function setShiftKey(value: Boolean): InputKey {
            this.shiftKey = value;
            return this;
        }

        public function setAltKey(value: Boolean): InputKey {
            this.altKey = value;
            return this;
        }

        public function setFunctionKey(value: Boolean): InputKey {
            this.functionKey = value;
            return this;
        }
    }
}