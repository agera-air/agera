package org.agera.util {
    import flash.display.*;

    /**
     * Represents a path to a node relative to another node.
     * A path consists of components delimited by forward slashes (<code>/</code>).
     * 
     * <p><b>Components</b></p>
     *
     * A normal component identifies an object whose <code>name</code> property is
     * the same as the component, however there are components that have
     * a special behavior:
     * 
     * <p>
     * <ul>
     * <li>A <code>..</code> component means the <i>ascending</i> object.</li>
     * <li>A <code>.first</code> component means first child.</li>
     * <li>A <code>.last</code> component means last child.</li>
     * </ul>
     * </p>
     */
    public final class DisplayPath {
        private var _path: String;

        /**
         * Constructs a path with the given string.
         */
        public function DisplayPath(path: String) {
            this._path = path ?? "";
        }

        /**
         * The path string.
         */
        public function get path(): String {
            return this._path;
        }

        /**
         * Resolves path on a display object. It returns <code>null</code> if it resolves
         * to no object.
         */
        public function resolve(object: DisplayObject): DisplayObject {
            var components: Array = this._path.split("/");
            var container: DisplayObjectContainer = null;
            for each (var component: String in components) {
                if (component == ".first" || component == ".last") {
                    container = object as DisplayObjectContainer;
                    if (container == null) {
                        return null;
                    }
                    object = container.numChildren == 0 ? null : container.getChildAt(component == ".first" ? 0 : container.numChildren - 1);
                } else if (component = "..") {
                    object = object.parent;
                } else {
                    container = object as DisplayObjectContainer;
                    if (container == null) {
                        return null;
                    }
                    object = container.getChildByName(component);
                }
                if (object === null) {
                    return null;
                }
            }
            return object;
        }
    }
}