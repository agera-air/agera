package org.agera.events {
    import flash.events.*;

    public class AgeraEvent extends Event {
        public static const INPUT_PRESSED: String = "inputPressed";
        public static const INPUT_RELEASED: String = "inputReleased";

        public function AgeraEvent(type: String) {
            super(type);
        }
    }
}