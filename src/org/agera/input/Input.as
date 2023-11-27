package org.agera.input {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.agera.events.AgeraEvent;

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
     * Mapping for keyboard and gamepad inputs.
     */
    public final class Input extends EventDispatcher {
        // `Map.<KeyCode, KeyState>`
        // `KeyCode` is a Number from the `Keyboard` key code constants
        private var keyStates: Dictionary = new Dictionary();

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