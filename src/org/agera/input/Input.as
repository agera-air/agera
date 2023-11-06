package org.agera.input {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    [Event(name = "inputPressed", type = "org.agera.events.AgeraEvent")]
    [Event(name = "inputReleased", type = "org.agera.events.AgeraEvent")]
    /**
     * Input mapping and handling.
     */
    public class Input extends EventDispatcher {
        // `Map.<KeyCode, KeyState>`
        // KeyCode is a Number from the Keyboard key code constants
        private var mKeys: Dictionary = new Dictionary();

        public function Input(stage: Stage) {
            super();
        }
    }
}