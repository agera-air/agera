package org.agera.input {
    /**
     * Represents a set of input keys and gamepad buttons as a single action.
     */
    public final class InputAction {
        private var mName: String;
        internal var mKeys: Vector.<InputKey> = new <InputKey> [];

        public function InputAction(name: String) {
            this.mName = name;
        }

        /**
         * The action's name.
         */
        public function get name(): String {
            return this.mName;
        }

        /**
         * Adds a key as part of the set.
         */
        public function key(key: InputKey): InputAction {
            this.mKeys.push(key);
            return this;
        }
    }
}