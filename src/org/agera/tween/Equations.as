package org.agera.tween {
    /*
     * Disclaimer for Robert Penner's Easing Equations license:
     *
     * TERMS OF USE - EASING EQUATIONS
     */

    /**
     * @private
     * @internal This implementation is based on the archived Caurina Tweener by
     * Zeh Fernando (original source at https://github.com/zeh/tweener).
     * The easing equations are a work from Robert Penner.
     */
    internal final class Equations {
        public static const map: Object = createMap();

        public static function createMap(): Object {
            const object: Object = {};
            object[Easing.NONE] = easeNone;

            object[Easing.LINEAR] = easeNone;

            object[Easing.IN_SINE] = easeInSine;
            object[Easing.OUT_SINE] = easeOutSine;
            object[Easing.IN_OUT_SINE] = easeInOutSine;
            object[Easing.OUT_IN_SINE] = easeOutInSine;

            object[Easing.IN_QUADRATIC] = easeInQuad;
            object[Easing.OUT_QUADRATIC] = easeOutQuad;
            object[Easing.IN_OUT_QUADRATIC] = easeInOutQuad;
            object[Easing.OUT_IN_QUADRATIC] = easeOutInQuad;

            object[Easing.IN_CUBIC] = easeInCubic;
            object[Easing.OUT_CUBIC] = easeOutCubic;
            object[Easing.IN_OUT_CUBIC] = easeInOutCubic;
            object[Easing.OUT_IN_CUBIC] = easeOutInCubic;

            object[Easing.IN_QUARTIC] = easeInQuart;
            object[Easing.OUT_QUARTIC] = easeOutQuart;
            object[Easing.IN_OUT_QUARTIC] = easeInOutQuart;
            object[Easing.OUT_IN_QUARTIC] = easeOutInQuart;

            object[Easing.IN_QUINTIC] = easeInQuint;
            object[Easing.OUT_QUINTIC] = easeOutQuint;
            object[Easing.IN_OUT_QUINTIC] = easeInOutQuint;
            object[Easing.OUT_IN_QUINTIC] = easeOutInQuint;

            object[Easing.IN_CIRCULAR] = easeInCirc;
            object[Easing.OUT_CIRCULAR] = easeOutCirc;
            object[Easing.IN_OUT_CIRCULAR] = easeInOutCirc;
            object[Easing.OUT_IN_CIRCULAR] = easeOutInCirc;

            object[Easing.IN_EXPONENTIAL] = easeInExpo;
            object[Easing.OUT_EXPONENTIAL] = easeOutExpo;
            object[Easing.IN_OUT_EXPONENTIAL] = easeInOutExpo;
            object[Easing.OUT_IN_EXPONENTIAL] = easeOutInExpo;

            object[Easing.IN_ELASTIC] = easeInElastic;
            object[Easing.OUT_ELASTIC] = easeOutElastic;
            object[Easing.IN_OUT_ELASTIC] = easeInOutElastic;
            object[Easing.OUT_IN_ELASTIC] = easeOutInElastic;

            object[Easing.IN_BOUNCE] = easeInBounce;
            object[Easing.OUT_BOUNCE] = easeOutBounce;
            object[Easing.IN_OUT_BOUNCE] = easeInOutBounce;
            object[Easing.OUT_IN_BOUNCE] = easeOutInBounce;

            object[Easing.IN_BACK] = easeInBack;
            object[Easing.OUT_BACK] = easeOutBack;
            object[Easing.IN_OUT_BACK] = easeInOutBack;
            object[Easing.OUT_IN_BACK] = easeOutInBack;

            return object;
        }

        /**
         * Easing equation function for a simple linear tweening, with no easing.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeNone(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c*t/d + b;
        }
    
        /**
         * Easing equation function for a quadratic (t^2) easing in: accelerating from zero velocity.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInQuad(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c*(t/=d)*t + b;
        }
    
        /**
         * Easing equation function for a quadratic (t^2) easing out: decelerating to zero velocity.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutQuad(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return -c *(t/=d)*(t-2) + b;
        }
    
        /**
         * Easing equation function for a quadratic (t^2) easing in/out: acceleration until halfway, then deceleration.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInOutQuad(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if ((t/=d/2) < 1) return c/2*t*t + b;
            return -c/2 * ((--t)*(t-2) - 1) + b;
        }
    
        /**
         * Easing equation function for a quadratic (t^2) easing out/in: deceleration until halfway, then acceleration.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutInQuad(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutQuad (t*2, b, c/2, d, otherParams);
            return easeInQuad((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    
        /**
         * Easing equation function for a cubic (t^3) easing in: accelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInCubic(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c*(t/=d)*t*t + b;
        }
    
        /**
         * Easing equation function for a cubic (t^3) easing out: decelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutCubic(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c*((t=t/d-1)*t*t + 1) + b;
        }
    
        /**
         * Easing equation function for a cubic (t^3) easing in/out: acceleration until halfway, then deceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInOutCubic(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if ((t/=d/2) < 1) return c/2*t*t*t + b;
            return c/2*((t-=2)*t*t + 2) + b;
        }
    
        /**
         * Easing equation function for a cubic (t^3) easing out/in: deceleration until halfway, then acceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutInCubic(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutCubic (t*2, b, c/2, d, otherParams);
            return easeInCubic((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    
        /**
         * Easing equation function for a quartic (t^4) easing in: accelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInQuart(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c*(t/=d)*t*t*t + b;
        }
    
        /**
         * Easing equation function for a quartic (t^4) easing out: decelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutQuart(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return -c * ((t=t/d-1)*t*t*t - 1) + b;
        }
    
        /**
         * Easing equation function for a quartic (t^4) easing in/out: acceleration until halfway, then deceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInOutQuart(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
            return -c/2 * ((t-=2)*t*t*t - 2) + b;
        }
    
        /**
         * Easing equation function for a quartic (t^4) easing out/in: deceleration until halfway, then acceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutInQuart(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutQuart (t*2, b, c/2, d, otherParams);
            return easeInQuart((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    
        /**
         * Easing equation function for a quintic (t^5) easing in: accelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInQuint(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c*(t/=d)*t*t*t*t + b;
        }
    
        /**
         * Easing equation function for a quintic (t^5) easing out: decelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutQuint(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c*((t=t/d-1)*t*t*t*t + 1) + b;
        }
    
        /**
         * Easing equation function for a quintic (t^5) easing in/out: acceleration until halfway, then deceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInOutQuint(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
            return c/2*((t-=2)*t*t*t*t + 2) + b;
        }
    
        /**
         * Easing equation function for a quintic (t^5) easing out/in: deceleration until halfway, then acceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutInQuint(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutQuint (t*2, b, c/2, d, otherParams);
            return easeInQuint((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    
        /**
         * Easing equation function for a sinusoidal (sin(t)) easing in: accelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInSine(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
        }
    
        /**
         * Easing equation function for a sinusoidal (sin(t)) easing out: decelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutSine(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c * Math.sin(t/d * (Math.PI/2)) + b;
        }
    
        /**
         * Easing equation function for a sinusoidal (sin(t)) easing in/out: acceleration until halfway, then deceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInOutSine(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
        }
    
        /**
         * Easing equation function for a sinusoidal (sin(t)) easing out/in: deceleration until halfway, then acceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutInSine(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutSine (t*2, b, c/2, d, otherParams);
            return easeInSine((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    
        /**
         * Easing equation function for an exponential (2^t) easing in: accelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInExpo(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b - c * 0.001;
        }
    
        /**
         * Easing equation function for an exponential (2^t) easing out: decelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutExpo(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return (t==d) ? b+c : c * 1.001 * (-Math.pow(2, -10 * t/d) + 1) + b;
        }
    
        /**
         * Easing equation function for an exponential (2^t) easing in/out: acceleration until halfway, then deceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInOutExpo(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t==0) return b;
            if (t==d) return b+c;
            if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b - c * 0.0005;
            return c/2 * 1.0005 * (-Math.pow(2, -10 * --t) + 2) + b;
        }
    
        /**
         * Easing equation function for an exponential (2^t) easing out/in: deceleration until halfway, then acceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutInExpo(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutExpo (t*2, b, c/2, d, otherParams);
            return easeInExpo((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    
        /**
         * Easing equation function for a circular (sqrt(1-t^2)) easing in: accelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInCirc(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
        }
    
        /**
         * Easing equation function for a circular (sqrt(1-t^2)) easing out: decelerating from zero velocity.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutCirc(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
        }
    
        /**
         * Easing equation function for a circular (sqrt(1-t^2)) easing in/out: acceleration until halfway, then deceleration.
          *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInOutCirc(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
            return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
        }
    
        /**
         * Easing equation function for a circular (sqrt(1-t^2)) easing out/in: deceleration until halfway, then acceleration.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutInCirc(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutCirc (t*2, b, c/2, d, otherParams);
            return easeInCirc((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    
        /**
         * Easing equation function for an elastic (exponentially decaying sine wave) easing in: accelerating from zero velocity.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @param a        Amplitude.
         * @param p        Period.
         * @return The correct value.
         */
        public static function easeInElastic(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t==0) return b;
            if ((t/=d)==1) return b+c;
            var p: Number = !Boolean(otherParams) || isNaN(otherParams.period) ? d*.3 : otherParams.period;
            var s: Number;
            var a: Number = !Boolean(otherParams) || isNaN(otherParams.amplitude) ? 0 : otherParams.amplitude;
            if (!Boolean(a) || a < Math.abs(c)) {
                a = c;
                s = p/4;
            } else {
                s = p/(2*Math.PI) * Math.asin (c/a);
            }
            return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
        }
    
        /**
         * Easing equation function for an elastic (exponentially decaying sine wave) easing out: decelerating from zero velocity.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @param a        Amplitude.
         * @param p        Period.
         * @return The correct value.
         */
        public static function easeOutElastic(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t==0) return b;
            if ((t/=d)==1) return b+c;
            var p: Number = !Boolean(otherParams) || isNaN(otherParams.period) ? d*.3 : otherParams.period;
            var s: Number;
            var a: Number = !Boolean(otherParams) || isNaN(otherParams.amplitude) ? 0 : otherParams.amplitude;
            if (!Boolean(a) || a < Math.abs(c)) {
                a = c;
                s = p/4;
            } else {
                s = p/(2*Math.PI) * Math.asin (c/a);
            }
            return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b);
        }
    
        /**
         * Easing equation function for an elastic (exponentially decaying sine wave) easing in/out: acceleration until halfway, then deceleration.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @param a        Amplitude.
         * @param p        Period.
         * @return The correct value.
         */
        public static function easeInOutElastic(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t==0) return b;
            if ((t/=d/2)==2) return b+c;
            var p: Number = !Boolean(otherParams) || isNaN(otherParams.period) ? d*(.3*1.5) : otherParams.period;
            var s: Number;
            var a: Number = !Boolean(otherParams) || isNaN(otherParams.amplitude) ? 0 : otherParams.amplitude;
            if (!Boolean(a) || a < Math.abs(c)) {
                a = c;
                s = p/4;
            } else {
                s = p/(2*Math.PI) * Math.asin (c/a);
            }
            if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
            return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
        }
    
        /**
         * Easing equation function for an elastic (exponentially decaying sine wave) easing out/in: deceleration until halfway, then acceleration.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @param a        Amplitude.
         * @param p        Period.
         * @return The correct value.
         */
        public static function easeOutInElastic(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutElastic (t*2, b, c/2, d, otherParams);
            return easeInElastic((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    
        /**
         * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in: accelerating from zero velocity.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @param s        Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
         * @return The correct value.
         */
        public static function easeInBack(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            var s: Number = !Boolean(otherParams) || isNaN(otherParams.overshoot) ? 1.70158 : otherParams.overshoot;
            return c*(t/=d)*t*((s+1)*t - s) + b;
        }
    
        /**
         * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out: decelerating from zero velocity.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @param s        Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
         * @return The correct value.
         */
        public static function easeOutBack(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            var s: Number = !Boolean(otherParams) || isNaN(otherParams.overshoot) ? 1.70158 : otherParams.overshoot;
            return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
        }
    
        /**
         * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in/out: acceleration until halfway, then deceleration.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @param s        Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
         * @return The correct value.
         */
        public static function easeInOutBack(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            var s: Number = !Boolean(otherParams) || isNaN(otherParams.overshoot) ? 1.70158 : otherParams.overshoot;
            if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
            return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
        }
    
        /**
         * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out/in: deceleration until halfway, then acceleration.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @param s        Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
         * @return The correct value.
         */
        public static function easeOutInBack(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutBack (t*2, b, c/2, d, otherParams);
            return easeInBack((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    
        /**
         * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in: accelerating from zero velocity.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInBounce(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            return c - easeOutBounce (d-t, 0, c, d) + b;
        }
    
        /**
         * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing out: decelerating from zero velocity.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutBounce(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if ((t/=d) < (1/2.75)) {
                return c*(7.5625*t*t) + b;
            } else if (t < (2/2.75)) {
                return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
            } else if (t < (2.5/2.75)) {
                return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
            } else {
                return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
            }
        }
    
        /**
         * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in/out: acceleration until halfway, then deceleration.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeInOutBounce(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeInBounce (t*2, 0, c, d) * .5 + b;
            else return easeOutBounce (t*2-d, 0, c, d) * .5 + c*.5 + b;
        }
    
        /**
         * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing out/in: deceleration until halfway, then acceleration.
         *
         * @param t Current time (in frames or seconds).
         * @param b Starting value.
         * @param c Change needed in value.
         * @param d Expected easing duration (in frames or seconds).
         * @return The correct value.
         */
        public static function easeOutInBounce(t: Number, b: Number, c: Number, d: Number, otherParams: Object = null): Number {
            if (t < d/2) return easeOutBounce (t*2, b, c/2, d, otherParams);
            return easeInBounce((t*2)-d, b+c/2, c/2, d, otherParams);
        }
    }
}