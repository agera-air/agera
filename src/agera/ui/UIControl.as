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
        // Used as output when calculating outer size.
        private static const SIBLINGS: Vector.<UIControl> = new <UIControl> [];

        /**
         * Indicates the minimum outer width of the control.
         */
        public var widthMinimum: Number = 0;

        /**
         * Indicates the minimum outer height of the control.
         */
        public var heightMinimum: Number = 0;

        private var mWidthOuter: Number = 0;

        private var mHeightOuter: Number = 0;

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
         */
        public var focusNeighborTop: String = null;

        /**
         * Indicates the neighbor control to focus when
         * pressing <code>"navigateDown"</code>.
         */
        public var focusNeighborBottom: String = null;

        /**
         * Indicates the neighbor control to focus when
         * pressing <code>"navigateLeft"</code>.
         */
        public var focusNeighborLeft: String = null;

        /**
         * Indicates the neighbor control to focus when
         * pressing <code>"navigateRight"</code>.
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

        // Layout stretch ratio is not yet supported.
        /**
         * If this control and at least one of its neighbors are set to expand in the layout,
         * the parent container will let it take more or less space depending
         * on this property. If this control has a stretch ratio of 2
         * and its neighbor a stretch ratio of 1, this control will take
         * two thirds of the available space.
         */
        private var mLayoutStretchRatio: Number = 1;

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
            // self.addEventListener(KeyboardEvent.KEY_DOWN, self.UIControl_handleKeyDownEvent);
            self.addEventListener(FocusEvent.FOCUS_IN, self.UIControl_handleFocusEvent);
            self.addEventListener(FocusEvent.FOCUS_OUT, self.UIControl_handleFocusEvent);
            self.addEventListener(Event.ENTER_FRAME, function(evt: Event): void {
                var prevWidth: Number = self.mWidthOuter;
                var prevHeight: Number = self.mHeightOuter;
                self.updateSizeOuter();
                var sizeChanged: Boolean = prevWidth != self.mWidthOuter || prevHeight != self.mHeightOuter;
                if (self.mClipContents && (sizeChanged || !self.mMaskDrawn)) {
                    self.mMask.graphics.clear();
                    self.mMask.graphics.beginFill(0);
                    self.mMask.graphics.drawRect(0, 0, self.mWidthOuter, self.mHeightOuter);
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
         * Read-only left padding derived from the control's theme.
         */
        public function get paddingLeft(): Number {
            var props: * = this.theme.properties;
            var padding: * = props.padding;
            if (typeof padding == "number") {
                return padding;
            }
            if (typeof padding == "object" && typeof padding.left == "number") {
                return padding.left;
            }
            return 0;
        }

        /**
         * Read-only right padding derived from the control's theme.
         */
        public function get paddingRight(): Number {
            var props: * = this.theme.properties;
            var padding: * = props.padding;
            if (typeof padding == "number") {
                return padding;
            }
            if (typeof padding == "object" && typeof padding.right == "number") {
                return padding.right;
            }
            return 0;
        }

        /**
         * Read-only left padding derived from the control's theme.
         */
        public function get paddingTop(): Number {
            var props: * = this.theme.properties;
            var padding: * = props.padding;
            if (typeof padding == "number") {
                return padding;
            }
            if (typeof padding == "object" && typeof padding.top == "number") {
                return padding.top;
            }
            return 0;
        }

        /**
         * Read-only bottom padding derived from the control's theme.
         */
        public function get paddingBottom(): Number {
            var props: * = this.theme.properties;
            var padding: * = props.padding;
            if (typeof padding == "number") {
                return padding;
            }
            if (typeof padding == "object" && typeof padding.bottom == "number") {
                return padding.bottom;
            }
            return 0;
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
         *
        public function get hasFocus(): Boolean {
            return this.focusable && (this is TextInput ? this.stage.focus == this.getChildByName("_textField") : this.stage.focus == this);
        }
        */

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

        private function UIControl_handleFocusEvent(event: FocusEvent): void {
            this.updateSkin();
        }

        /*
        private function UIControl_handleKeyDownEvent(event: KeyboardEvent): void {
            // # focus switch

            if (!this.hasFocus) {
                return;
            }

            var app: AgeraApplication = AgeraApplication.application;
            var pointedTo: DisplayObject = null;

            // next focus
            if (app.input.getAction("uiFocusNext").matchesKeyboardEvent(event)) {
                var next: DisplayObject = null;
                if (this.focusNeighborNext != null) {
                    next = DisplayListPath.resolve(this, this.focusNeighborNext);
                    if (next == null || !DisplayObject_focusable(next)) {
                        throw new Error("Specified focusNeighborNext resolves to no object or is not focusable.");
                    }
                } else {
                    next = UIControl_Hierarchy.nextFocusTarget(this);
                }
                if (next != null) {
                    this.stage.focus = next as InteractiveObject;
                }
            // previous focus
            } else if (app.getAction("uiFocusPrevious").matchesKeyboardEvent(event)) {
                var previous: DisplayObject = null;
                if (this.focusNeighborPrevious != null) {
                    previous = this.focusNeighborPrevious.getChild(this);
                    if (previous == null || !flashswing.controls.isFocusable(previous)) {
                        throw new Error("Specified focusNeighborPrevious resolves to no object or is not focusable.");
                    }
                } else {
                    previous = Hierarchy.previousFocusTarget(this);
                }
                if (previous != null) {
                    this.stage.focus = previous as InteractiveObject;
                }
            // up focus
            } else if (app.getAction("uiUp").matchesKeyboardEvent(event)) {
                if (this.focusNeighborUp != null) {
                    pointedTo = this.focusNeighborUp.getChild(this);
                    if (pointedTo == null || !flashswing.controls.isFocusable(pointedTo)) {
                        throw new Error("Specified focusNeighborUp resolves to no object or is not focusable.");
                    }
                    this.stage.focus = pointedTo as InteractiveObject;
                }
            // down focus
            } else if (app.getAction("uiDown").matchesKeyboardEvent(event)) {
                if (this.focusNeighborDown != null) {
                    pointedTo = this.focusNeighborDown.getChild(this);
                    if (pointedTo == null || !flashswing.controls.isFocusable(pointedTo)) {
                        throw new Error("Specified focusNeighborDown resolves to no object or is not focusable.");
                    }
                    this.stage.focus = pointedTo as InteractiveObject;
                }
            // left focus
            } else if (app.getAction("uiLeft").matchesKeyboardEvent(event)) {
                if (this.focusNeighborLeft != null) {
                    pointedTo = this.focusNeighborLeft.getChild(this);
                    if (pointedTo == null || !flashswing.controls.isFocusable(pointedTo)) {
                        throw new Error("Specified focusNeighborLeft resolves to no object or is not focusable.");
                    }
                    this.stage.focus = pointedTo as InteractiveObject;
                }
            // right focus
            } else if (app.getAction("uiRight").matchesKeyboardEvent(event)) {
                if (this.focusNeighborRight != null) {
                    pointedTo = this.focusNeighborRight.getChild(this);
                    if (pointedTo == null || !flashswing.controls.isFocusable(pointedTo)) {
                        throw new Error("Specified focusNeighborRight resolves to no object or is not focusable.");
                    }
                    this.stage.focus = pointedTo as InteractiveObject;
                }
            }
        }
        */

        private function updateSizeOuter(): void {
            this.mWidthOuter = this.widthMinimum;
            this.mHeightOuter = this.heightMinimum;
            var parentControl: UIControl = this.parent as UIControl;
            if (parentControl != null) {
                // - Expand?
                //   - Neighbors set to expand in the same direction
                //     are expanded by dividing the available space
                //     and taking the stretch ratio of each control
                //     into consideration.
                // - Sizing?
                if (this.mLayoutHorizontalSizing != null && this.mLayoutHorizontalSizing.expand) {
                    this.UIControl_expandControlWidth(parentControl);
                }
                if (this.mLayoutVerticalSizing != null && this.mLayoutVerticalSizing.expand) {
                    this.UIControl_expandControlHeight(parentControl);
                }
            }
        }

        private function UIControl_expandControlWidth(parentControl: UIControl): void {
            UIControl_Hierarchy.neighborExpandControls(this, SIBLINGS);
            SIBLINGS.push(this);
            var siblingsTotalWidth: Number = 0;
            for each (var sibling: UIControl in SIBLINGS) {
                sibling.mWidthOuter = sibling.widthMinimum;
                siblingsTotalWidth +=
                    sibling.mWidthOuter +
                    sibling.paddingLeft + sibling.paddingRight;
            }
            var gapTotal: Number = parentControl.gap * (SIBLINGS.length - 1);
            var delta: Number = parentControl.widthInner - (siblingsTotalWidth + gapTotal);
            this.mWidthOuter += delta < 0 ? 0 : delta / SIBLINGS.length;
            SIBLINGS.length = 0;
        }

        private function UIControl_expandControlHeight(parentControl: UIControl): void {
            UIControl_Hierarchy.neighborExpandControls(this, SIBLINGS);
            SIBLINGS.push(this);
            var siblingsTotalHeight: Number = 0;
            for each (var sibling: UIControl in SIBLINGS) {
                sibling.mHeightOuter = sibling.heightMinimum;
                siblingsTotalHeight +=
                    sibling.mHeightOuter +
                    sibling.paddingTop + sibling.paddingBottom;
            }
            var gapTotal: Number = parentControl.gap * (SIBLINGS.length - 1);
            var delta: Number = parentControl.heightInner - (siblingsTotalHeight + gapTotal);
            this.mHeightOuter += delta < 0 ? 0 : delta / SIBLINGS.length;
            SIBLINGS.length = 0;
        }

        /**
         * Returns the inner width of a control; that is, the width available inside.
         * This is usually <code>widthOuter - strokeSize - scrollBarWidth</code>.
         */
        public function get widthInner(): Number {
            throw new Error("widthInner is not implemented for " + String(this));
        }

        /**
         * Returns the inner height of a control; that is, the height available inside.
         * This is usually <code>heightOuter - strokeSize - scrollBarHeight</code>.
         */
        public function get heightInner(): Number {
            throw new Error("heightInner is not implemented for " + String(this));
        }

        /**
         * Returns the computed width of a control. This property is
         * updated on every frame to reflect the actual width.
         */
        public function get widthOuter(): Number {
            return this.mWidthOuter;
        }

        /**
         * Returns the computed height of a control. This property is
         * updated on every frame to reflect the actual height.
         */
        public function get heightOuter(): Number {
            return this.mHeightOuter;
        }
    }
}