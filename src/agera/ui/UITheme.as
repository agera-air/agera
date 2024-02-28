package agera.ui {
    import flash.utils.Dictionary;

    public final class UITheme {
        private const _controls: Dictionary = new Dictionary();

        public function UITheme() {}

        public function get(controlClass: Class): * {
            return this._controls[controlClass];
        }

        public function set(controlClass: Class, options: *): void {
            this._controls[controlClass] = options;
        }
    }
}