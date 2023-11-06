package org.agera.util {
    /**
     * Separates a number into commas.
     */
    public function commaSeparatedNumber(number: Number): String {
        var str: String = number.toString();
        var decimalPart: String = "";
        var i: int = str.indexOf('.');
        if (i != -1) {
            decimalPart = str.slice(i);
            str = str.slice(0, i);
        }
        var j: int = str.length;
        var mod: int = j % 3;
        var res: String = '';
        for (i = 0; i < j; ++i) {
            if (i != 0 && i % 3 == mod) {
                res += ',';
            }
            res += str.charAt(i);
        }
        return res;
    }
}