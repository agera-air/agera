package org.agera.util {
    import org.agera.errors.*;

    /**
     * Asserts that two values are strictly equal.
     * @throws org.agera.errors.AssertionError Thrown if left and right are not strictly equal.
     */
    public function assertEq(left: *, right: *, message: String = ""): void {
        if (left !== right) {
            if (message == "") {
                message = format("Operands must be strictly equal; left: {1}, right: {2}", [left, right]);
            }
            throw new AssertionError(message);
        }
    }
}