# Getting started

## Requirements

To build the library, simply install [asconfigc](https://github.com/BowlerHatLLC/asconfigc).

## Installation

To install the library, clone the repository and run `asconfigc` to get a SWC. Copy the resulting SWC into the libraries folder of your Adobe AIR project.

## Program

The entry point for an Agera application looks like this:

```as3
package {
    import flash.display.*;
    import flash.events.*;
    import agera.core.*;

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