# Input

`org.agera.input` currently provides handling of keyboard inputs.

## Example

```as3
import org.agera.events.*;
import org.agera.input.*;
import flash.events.*;
import flash.ui.*;

// application: AgeraApplication

application.input.setActions(new <InputAction> [
    new InputAction("actionId")
        .key(new InputKey(Keyboard.SPACE))
        .key(new InputKey(Keyboard.ENTER)),
]);

// Determines whether an action is pressed
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