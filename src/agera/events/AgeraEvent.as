package agera.events {
    import flash.events.*;

    public class AgeraEvent extends Event {
        public static const INPUT_PRESSED: String = "inputPressed";
        public static const INPUT_RELEASED: String = "inputReleased";
        public static const ACTIONS_UPDATE: String = "actionsUpdate";
        public static const FINISHED: String = "finished";
        public static const UPDATE_SKIN: String = "updateSkin";
        public static const DEFAULT_THEME_UPDATED: String = "defaultThemeUpdated";

        public function AgeraEvent(type: String) {
            super(type);
        }
    }
}