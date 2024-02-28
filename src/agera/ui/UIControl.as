package agera.ui {
    import flash.display.*;
    import agera.core.*;
    import agera.events.*;
    import agera.util.*;

    /**
     * The base class used for user interface controls.
     */
    public class UIControl extends Sprite {
        /**
         * Specifies the focus mode for the control. This is
         * used to disable focus for a specific control,
         * but not for its children.
         * 
         * @default FocusMode.NONE
         */
        public var focusMode: FocusMode = FocusMode.NONE;

        /**
         * Indicates the neighbor control to focus when
         * pressing <code>"navigateUp"</code>.
         * 
         * If not specified, it is deduced automatically.
         */
        public var focusNeighborTop: String = null;

        /**
         * Indicates the neighbor control to focus when
         * pressing <code>"navigateDown"</code>.
         * 
         * If not specified, it is deduced automatically.
         */
        public var focusNeighborBottom: String = null;

        /**
         * Indicates the neighbor control to focus when
         * pressing <code>"navigateLeft"</code>.
         * 
         * If not specified, it is deduced automatically.
         */
        public var focusNeighborLeft: String = null;

        /**
         * Indicates the neighbor control to focus when
         * pressing <code>"navigateRight"</code>.
         * 
         * If not specified, it is deduced automatically.
         */
        public var focusNeighborRight: String = null;

        /**
         * Indicates the neighbor control to focus when
         * pressing <code>"focusPrevious"</code>, typically the key combination
         * Shift + Tab.
         * 
         * If not specified, it is deduced automatically.
         */
        public var focusNeighborPrevious: String = null;

        /**
         * Indicates the neighbor control to focus when
         * pressing <code>"focusNext"</code>, typically the Tab key.
         * 
         * If not specified, it is deduced automatically.
         */
        public var focusNeighborNext: String = null;

        /**
         * Tells whether the control is in disabled state.
         */
        public function get disabled(): Boolean {
            return false;
        }

        /**
         * Tells whether the control may receive focus.
         */
        public function get focusable(): Boolean {
            return this.visible && !this.disabled && this.focusMode != FocusMode.NONE;
        }

        /**
         * Tells whether the control currently has focus.
         */
        public function get hasFocus(): Boolean {
            return this.focusable && (this is TextInput ? this.stage.focus == this.getChildByName("_textField") : this.stage.focus == this);
        }

        /**
         * Focuses the control.
         */
        public function focus(): void {
            this.stage.focus = this;
        }
    }
}