package org.agera.input {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.agera.events.AgeraEvent;
    import flash.ui.Keyboard;
    import org.agera.util.assert;

    /**
     * Dispatched when any key or gamepad button is pressed.
     *
     * @eventType org.agera.events.AgeraEvent.INPUT_PRESSED
     */
    [Event(name = "inputPressed", type = "org.agera.events.AgeraEvent")]
    /**
     * Dispatched when any key or gamepad button is released.
     *
     * @eventType org.agera.events.AgeraEvent.INPUT_RELEASED
     */
    [Event(name = "inputReleased", type = "org.agera.events.AgeraEvent")]
    /**
     * Dispatched when the collection of actions is updated.
     *
     * @eventType org.agera.events.AgeraEvent.ACTIONS_UPDATE
     */
    [Event(name = "actionsUpdate", type = "org.agera.events.AgeraEvent")]
    /**
     * Collection for keyboard and gamepad inputs.
     */
    public final class Input extends EventDispatcher {
        // `Map.<KeyCode, KeyState>`
        // `KeyCode` is a Number from the `Keyboard` key code constants
        private const keyStates: Dictionary = new Dictionary();

        // `Map.<String, InputAction>`
        private var actions: Dictionary = new Dictionary();

        /**
         * Returns a clone of the action collection contained by the <code>Input</code> object.
         */
        public function getActions(): Dictionary {
            return InputAction.cloneCollection(this.actions);
        }

        /**
         * Sets the action collection of the <code>Input</code> object.
         */
        public function setActions(collection: Vector.<InputAction>): void {
            this.actions = this.nativeActions();
            InputAction.extendCollection(this.actions, InputAction.vectorToDictionary(collection));
            this.dispatchEvent(new AgeraEvent(AgeraEvent.ACTIONS_UPDATE));
        }

        /**
         * Returns an action collection containing the native actions recognized
         * by Agera.
         * 
         * <p>The following native actions are supported:
         * <ul>
         *   <li><code>"navigateLeft"</code> — Left navigation in the user interface.</li>
         *   <li><code>"navigateRight"</code> — Right navigation in the user interface.</li>
         *   <li><code>"navigateUp"</code> — Up navigation in the user interface.</li>
         *   <li><code>"navigateDown"</code> — Down navigation in the user interface.</li>
         * </ul>
         * </p>
         */
        public function nativeActions(): Dictionary {
            return InputAction.vectorToDictionary(new <InputAction> [
                new InputAction("navigateLeft")
                    .key(new InputKey(Keyboard.LEFT)),
                new InputAction("navigateRight")
                    .key(new InputKey(Keyboard.RIGHT)),
                new InputAction("navigateUp")
                    .key(new InputKey(Keyboard.UP)),
                new InputAction("navigateDown")
                    .key(new InputKey(Keyboard.DOWN)),
            ]);
        }

        /**
         * Indicates whether an action is pressed or not.
         *
         * @throws Error Thrown if the specified action name is not set.
         */
        public function isPressed(actionName: String): Boolean {
            const action: InputAction = this.actions[actionName] as InputAction;
            assert(action != null, "The given action for input.isPressed() is not defined.");
            for each (var key: InputKey in action.mKeys) {
                const state: KeyState = this.keyStates[key.keyCode] as KeyState;
                const pressed: Boolean = state != null
                    && state.pressed
                    && (key.ctrlKey ? state.ctrlKey : !state.ctrlKey)
                    && (key.shiftKey ? state.shiftKey : !state.shiftKey)
                    && (key.altKey ? state.altKey : !state.altKey)
                    && (key.functionKey ? state.functionKey : !state.functionKey);
                if (pressed) {
                    return true;
                }
            }
            return false;
        }

        /**
         * @private
         */
        public function Input(stage: Stage) {
            super();
            const self: Input = this;
            // keyDown
            stage.addEventListener(KeyboardEvent.KEY_DOWN, function(evt: KeyboardEvent): void {
                var state: KeyState = keyStates[evt.keyCode];
                if (state == null) {
                    state = new KeyState();
                    keyStates[evt.keyCode] = state;
                }

                state.pressed = true;
                state.ctrlKey = evt.ctrlKey;
                state.shiftKey = evt.shiftKey;
                state.altKey = evt.altKey;
                state.functionKey = evt.functionKey;

                self.dispatchEvent(new AgeraEvent(AgeraEvent.INPUT_PRESSED));
            });
            // keyUp
            stage.addEventListener(KeyboardEvent.KEY_UP, function(evt: KeyboardEvent): void {
                var state: KeyState = keyStates[evt.keyCode];
                if (state == null) {
                    state = new KeyState();
                    keyStates[evt.keyCode] = state;
                }

                state.pressed = false;
                state.ctrlKey = false;
                state.shiftKey = false;
                state.altKey = false;
                state.functionKey = false;

                self.dispatchEvent(new AgeraEvent(AgeraEvent.INPUT_RELEASED));
            });
        }
    }
}