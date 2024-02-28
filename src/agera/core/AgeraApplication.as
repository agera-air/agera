package agera.core {
    import agera.events.*;
    import agera.input.*;
    import agera.ui.*;
    import agera.util.*;
    import flash.display.*;
    import flash.events.*;

    /**
     * Dispatched when <code>defaultTheme</code> is updated to a new theme.
     */
    [Event(name = "defaultThemeUpdated", type = "agera.events.AgeraEvent")]
    /**
     * The Agera application.
     */
    public class AgeraApplication extends Sprite {
        private static var mApplication: AgeraApplication = null;
        private var mInput: Input = null;
        private var mDefaultTheme: UITheme = null;

        /**
         * Returns the current application instance.
         */
        public static function get application(): AgeraApplication {
            assert(AgeraApplication.mApplication != null, "Application has not been initialized yet.");
            return AgeraApplication.mApplication;
        }

        public function AgeraApplication() {
            super();
            var self: AgeraApplication = this;

            assert(AgeraApplication.mApplication == null, "AgeraApplication must be constructed at most once.");
            AgeraApplication.mApplication = this;

            self.addEventListener(Event.ADDED_TO_STAGE, function(e: Event): void {
                self.mInput = new Input(self.stage);
            });
        }

        /**
         * The <code>Input</code> instance of the application, used for
         * mapping actions and determining which actions are pressed.
         */
        public function get input(): Input {
            assert(this.mInput != null, "application.input must be used after the application is added to the stage.");
            return this.mInput;
        }

        /**
         * Default theme for the application. Updating this property
         * fires the event <code>defaultThemeUpdated</code>.
         */
        public function get defaultTheme(): UITheme {
            return this.mDefaultTheme;
        }

        public function set defaultTheme(theme: UITheme): void {
            if (theme == this.mDefaultTheme) {
                return;
            }
            this.mDefaultTheme = theme;
            this.dispatchEvent(new AgeraEvent(AgeraEvent.DEFAULT_THEME_UPDATED));
        }

        /**
         * Listens to updates of the default theme within a display object,
         * dispatching the <code>updateSkin</code> event in that display object.
         */
        public function initializeDefaultTheme(object: DisplayObject): void {
            this.addEventListener(AgeraEvent.DEFAULT_THEME_UPDATED, function(evt: Event): void {
                object.dispatchEvent(new AgeraEvent(AgeraEvent.UPDATE_SKIN));
            });
        }
    }
}