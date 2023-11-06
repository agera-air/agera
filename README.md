# Agera for Adobe AIR

Agera provides facilities for developing Adobe AIR applications, including user interface, input handling and utility functions.

## Getting started

**Requirements**:

- Install [asconfigc](https://github.com/BowlerHatLLC/asconfigc)

**Installation**: To install the library, clone the repository and run `asconfigc` to get a SWC.

**Entry point**: The entry point for a Agera application looks like this:

```as3
package {
    import flash.display.*;
    import flash.events.*;
    import org.agera.core.*;

    public final class Main extends AgeraApplication {
        public function Main() {
            super();
            this.addEventListener(Event.ADDED_TO_STAGE, this.initialize);
        }

        private function initialize(event: Event): void {
            // Initialization
        }
    }
}
```