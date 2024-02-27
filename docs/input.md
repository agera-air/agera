# Input

`agera.input` provides handling of keyboard inputs using a collection of actions.

## Example

```as3
import agera.events.*;
import agera.input.*;
import flash.events.*;
import flash.ui.*;

// application: AgeraApplication

// Set the action collection
application.input.setActions(new <InputAction> [
    new InputAction("actionId")
        .key(new InputKey(Keyboard.SPACE))
        .key(new InputKey(Keyboard.ENTER)),
]);

// Indicates whether an action is pressed or not
application.input.isPressed("actionId");

// Event dispatched when any input is pressed
application.input.addEventListener(AgeraEvent.INPUT_PRESSED, function(e: Event): void {
    //
});

// Event dispatched when any input is released
application.input.addEventListener(AgeraEvent.INPUT_RELEASED, function(e: Event): void {
    //
});
```