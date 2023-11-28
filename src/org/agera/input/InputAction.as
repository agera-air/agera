package org.agera.input {
    import flash.utils.Dictionary;

    /**
     * Represents a set of input keys and gamepad buttons as a single action.
     */
    public final class InputAction {
        private var mName: String;

        /**
         * @private
         */
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

        /**
         * Clones the object.
         */
        public function clone(): InputAction {
            const result: InputAction = new InputAction(this.mName);
            result.mKeys = this.mKeys.map(function(key: InputKey, index: int, vector: Vector.<InputKey>): InputKey {
                return key.clone();
            });
            return this;
        }

        /**
         * Clones a <code>Dictionary</code> of <code>[String, InputAction]</code> pairs
         * by cloning each pair.
         */
        public static function cloneCollection(collection: Dictionary): Dictionary {
            const result: Dictionary = new Dictionary();
            for (var name: String in collection) {
                result[name] = InputAction(collection[name]).clone();
            }
            return result;
        }

        /**
         * Extends a <code>Dictionary</code> of <code>[String, InputAction]</code> pairs
         * with another compatible <code>Dictionary</code>, cloning each pair.
         */
        public static function extendCollection(collection: Dictionary, extendWith: Dictionary): void {
            for (var name: String in extendWith) {
                collection[name] = InputAction(extendWith[name]).clone();
            }
        }

        /**
         * Converts a <code>Dictionary</code> collection to a <code>Vector</code> collection.
         */
        public static function dictionaryToVector(collection: Dictionary): Vector.<InputAction> {
            const result: Vector.<InputAction> = new <InputAction> [];
            for (var name: String in collection) {
                result.push(InputAction(collection[name]));
            }
            return result;
        }

        /**
         * Converts a <code>Vector</code> collection to a <code>Dictionary</code> collection.
         */
        public static function vectorToDictionary(collection: Vector.<InputAction>): Dictionary {
            const result: Dictionary = new Dictionary;
            for each (var action: InputAction in collection) {
                result[action.name] = action;
            }
            return result;
        }
    }
}