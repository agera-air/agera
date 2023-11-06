package org.agera.core {
    import org.agera.util.*;
    import org.agera.input.*;
    import flash.display.*;
    import flash.events.*;

    /**
     * The Agera application.
     */
    public class AgeraApplication extends Sprite {
        private static var mApplication: AgeraApplication = null;
        private var mInput: Input = null;

        /**
         * Returns the current application instance.
         */
        public function get application(): AgeraApplication {
            assert(AgeraApplication.mApplication != null, "Application has not been initialized yet");
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
            assert(this.mInput != null, "application.input must be used after the application is added to the stage");
            return this.mInput;
        }
    }
}