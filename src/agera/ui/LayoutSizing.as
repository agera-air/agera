package agera.ui {
    /**
     * Used to determine the sizing of a control in a container.
     * The <code>LayoutSizing</code> constructor takes the
     * following syntax:
     * 
     * <listing version="3.0">
     * const sizing: LayoutSizing = new LayoutSizing({
     *     fill: optBoolean,
     *     shrinkCenter: optBoolean,
     *     shrinkEnd: optBoolean,
     *     expand: optBoolean
     * });
     * </listing>
     * 
     * <p><code>fill</code>, <code>shrinkCenter</code> and <code>shrinkEnd</code>
     *    are mutually exclusive. <code>fill</code> is the default boolean set to true among these three.</p>
     * 
     * <p><code>expand</code> is true by default.</p>
     */
    public final class LayoutSizing {
        private var _sizing: String = "fill";
        private var _expand: Boolean;

        /**
         * Constructor.
         */
        public function LayoutSizing(options: *) {
            options ||= {};
            for (var key: String in options) {
                var value: * = options[key];
                switch (key) {
                    case "expand":
                        this._expand = Boolean(value);
                        break;
                    case "fill":
                    case "shrinkCenter":
                    case "shrinkEnd":
                        this._sizing = value ? key : this._sizing;
                        break;
                    default:
                        throw new Error("LayoutSizing does not support property '" + key + "'");
                }
            }
        }

        /**
         * Tells whether to fill the container.
         */
        public function get fill(): Boolean {
            return this._sizing == "fill";
        }

        /**
         * Tells whether to align control to the center.
         */
        public function get shrinkCenter(): Boolean {
            return this._sizing == "shrinkCenter";
        }

        /**
         * Tells whether to align control to the end.
         */
        public function get shrinkEnd(): Boolean {
            return this._sizing == "shrinkEnd";
        }

        /**
         * Determines whether the control expands to available space in a container.
         */
        public function get expand(): Boolean {
            return this._expand;
        }
    }
}