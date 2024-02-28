package agera.ui {
    import flash.display.*;

    /**
     * Determines if a display object is focusable.
     */
    public function DisplayObject_focusable(object: DisplayObject): Boolean {
        if (!(object is InteractiveObject)) {
            return false;
        }
        return object is UIControl ? UIControl(object).focusable : true;
    }
}