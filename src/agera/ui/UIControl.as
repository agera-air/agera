package agera.ui {
    import flash.display.*;
    import flash.events.*;
    import agera.core.*;
    import agera.events.*;
    import agera.util.*;

    /**
     * Event dispatched when a property of the control updates such
     * that its skin must be rendered again.
     * @eventType agera.events.AgeraEvent.UPDATE_SKIN
     */
    [Event(name = "updateSkin", type = "agera.events.AgeraEvent")]
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
         * Indicates the scope display object of the
         * <code>focusNeighborTop</code>, <code>focusNeighborBottom</code>,
         * <code>focusNeighborLeft</code>, <code>focusNeighborRight</code>,
         * <code>focusNeighborPrevious</code> and <code>focusNeighborNext</code>
         * properties.
         */
        public var focusNeighborScope: String = null;

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
         * If this control and at least one of its neighbors are set to expand in the layout,
         * the parent container will let it take more or less space depending
         * on this property. If this control has a stretch ratio of 2
         * and its neighbor a stretch ratio of 1, this control will take
         * two thirds of the available space.
         */
        public var layoutStretchRatio: Number = 1;

        private var mLayoutHorizontalSizing: LayoutSizing = new LayoutSizing({
            fill: true
        });

        private var mLayoutVerticalSizing: LayoutSizing = new LayoutSizing({
            fill: true
        });

        /**
         * Indicates gap between children controls in <code>Row</code>
         * and <code>Column</code> containers.
         */
        public var gap: Number = 0;

        /**
         * @private
         */
        internal var mTheme: UITheme = null;

        /**
         * @private
         */
        internal var mThemeOverrides: * = undefined;

        /**
         * @private
         */
        internal var mThemeProperties: * = undefined;

        private var mClipContents: Boolean = false;
        private var mMask: Sprite = null;
        private var mMaskDrawn: Boolean = false;

        /**
         * Constructor.
         */
        public function UIControl() {
            super();
            var self: UIControl = this;
            self.addEventListener(KeyboardEvent.KEY_DOWN, self.UIControl_handleKeyDownEvent);
            self.addEventListener(FocusEvent.FOCUS_IN, self.UIControl_handleFocusEvent);
            self.addEventListener(FocusEvent.FOCUS_OUT, self.UIControl_handleFocusEvent);
            self.addEventListener(Event.ENTER_FRAME, function(evt: Event): void {
                var prevWidth: Number = self._outerWidth;
                var prevHeight: Number = self._outerHeight;
                self._updateControlSize();
                var sizeChanged: Boolean = prevWidth != self._outerWidth || prevHeight != self._outerHeight;
                if (self.mClipContents && (sizeChanged || !self.mMaskDrawn)) {
                    self.mMask.graphics.clear();
                    self.mMask.graphics.beginFill(0);
                    self.mMask.graphics.drawRect(0, 0, self._outerWidth, self._outerHeight);
                    self.mMask.graphics.endFill();
                    self.mMaskDrawn = true;
                }
            }, false, 10);
            self.addEventListener(AgeraEvent.UPDATE_SKIN, function(evt: Event): void {
                self.theme.updateProperties();
            }, false, 10);
        }

        /**
         * Accesses the particular theme of the control.
         */
        public final function get theme(): UIControlTheme {
            return new UIControlTheme(this);
        }

        /**
         * Indicates whether to clip overflowing contents.
         */
        public function get clipContents(): Boolean {
            return this.mClipContents;
        }

        public function set clipContents(value: Boolean): void {
            if (value == this.mClipContents) {
                return;
            }
            if (this.mMask != null) {
                this.removeChild(this.mMask);
                this.mMask = null;
            }
            this.mClipContents = value;
            this.mMaskDrawn = false;
            if (value) {
                this.mMask = new Sprite();
                this.mMask.name = "_clipMask";
                this.addChild(this.mMask);
            }
        }

        /**
         * Indicates a horizontal <code>LayoutSizing</code> for the control.
         * Assigning a plain object to this property converts it into a
         * <code>LayoutSizing</code> object by calling <code>new LayoutSizing(object)</code>.
         */
        public function get layoutHorizontalSizing(): * {
            return this.mLayoutHorizontalSizing;
        }

        public function set layoutHorizontalSizing(object: *): void {
            this.mLayoutHorizontalSizing = object is LayoutSizing ? object : new LayoutSizing(object);
        }

        /**
         * Indicates a vertical <code>LayoutSizing</code> for the control.
         * Assigning a plain object to this property converts it into a
         * <code>LayoutSizing</code> object by calling <code>new LayoutSizing(object)</code>.
         */
        public function get layoutVerticalSizing(): * {
            return this.mLayoutVerticalSizing;
        }

        public function set layoutVerticalSizing(object: *): void {
            this.mLayoutVerticalSizing = object is LayoutSizing ? object : new LayoutSizing(object);
        }

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

        /**
         * Updates the control's skin.
         */
        public function updateSkin(): void {
            this.dispatchEvent(new AgeraEvent(AgeraEvent.UPDATE_SKIN));
        }
    }
}