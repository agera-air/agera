package org.agera.util {
    import flash.display.*;
    import org.agera.util.*;

    public function displayObjectIsDescendantOf(object: DisplayObject, ascending: DisplayObject): Boolean {
        var parent: DisplayObject = object.parent;
        while (parent != null) {
            if (parent == ascending) {
                return true;
            }
            parent = parent.parent;
        }
        return false;
    }
}