package agera.ui {
    import flash.display.*;
    import agera.core.*;
    import agera.util.*;

    /**
     * Provides access methods to a particular control's theme.
     * This object results from acessing the <code>theme</code>
     * property of an <code>UIControl</code> object.
     */
    public final class UIControlTheme {
        private var mControl: UIControl;

        /**
         * @private
         */
        public function UIControlTheme(control: UIControl) {
            this.mControl = control;
        }

        /**
         * Specifies a theme for the control and any children controls.
         * <code>null</code> by default.
         */
        public function get theme(): UITheme {
            return this.mControl.mTheme;
        }

        public function set theme(value: UITheme): void {
            this.mControl.mTheme = value;
            this.mControl.updateSkin();
        }

        /**
         * Returns read-only theme properties specific to the control
         * based on <code>theme</code>, its theme overrides and
         * <code>AgeraApplication.application.defaultTheme</code>.
         */
        public final function get properties(): * {
            if (this.mControl.mThemeProperties === undefined) {
                this.updateProperties();
            }
            return this.mControl.mThemeProperties;
        }

        /**
         * Specifies direct theme properties for the control,
         * overriding the assigned theme.
         */
        public function get overrides(): * {
            return this.mControl.mThemeOverrides;
        }

        public function set overrides(value: *): void {
            this.mControl.mThemeOverrides = value;
            this.mControl.updateSkin();
        }

        /**
         * Overrides a theme property. The <code>properties</code>
         * argument accepts dots as member separators.
         */
        public function override(properties: String, value: *): void {
            var obj: * = {};
            var obj2: * = obj;
            var members: Array = properties.split(".");
            for each (var property: String in members) {
                var obj3: * = {};
                obj2[property] = obj3;
            }
            obj2[members[members.length - 1]] = value;
            this.mControl.updateSkin();
        }

        /**
         * Clears any theme overrides.
         */
        public function clearOverrides(): void {
            this.mControl.mThemeOverrides = undefined;
            this.mControl.updateSkin();
        }

        /**
         * @private
         */
        internal function updateProperties(): void {
            var thisConstructor: Class = (this.mControl as Object).constructor;
            this.mControl.mThemeProperties = {};
            var inheritedTheme: UITheme = null;
            var p: DisplayObject = this.mControl;
            while (p != null) {
                if (p is UIControl && UIControl(p).mTheme != null) {
                    inheritedTheme = UIControl(p).mTheme;
                    break;
                }
                p = p.parent;
            }
            inheritedTheme ||= AgeraApplication.application.defaultTheme;
            var inherited: * = inheritedTheme != null ? inheritedTheme.get(thisConstructor) : undefined;
            if (inherited !== undefined) {
                extendDeep(this.mControl.mThemeProperties, inherited);
            }
            if (this.mControl.mThemeOverrides !== undefined) {
                extendDeep(this.mControl.mThemeProperties, this.mControl.mThemeOverrides);
            }
        }
    }
}