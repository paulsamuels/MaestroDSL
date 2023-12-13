A Swift DSL for the [Maestro](https://maestro.mobile.dev) UI testing tool.

## Starter Project

If you have [Maestro](https://maestro.mobile.dev) installed in the default location you can open the `StarterProject` and hit run.
Once you've trusted the macro and hit run again you should see the simulator launch and start adding a contact in the contacts app.

## Basic Usage

Import the `MaestroDSL` package and declare a dependency on both `MaestroDSL` and `MaestroDSLMacro` (see the [StarterProject/Package.swift](https://github.com/paulsamuels/MaestroDSL/blob/main/StarterProject/Package.swift) for an example).

Now you can use the top level `maestroRun` command to build a flow to execute.
A flow that would add a contact to the contacts app might look like this:

```swift
import MaestroDSL

try! maestroRun("com.apple.MobileAddressBook") {
    LaunchApp("com.apple.MobileAddressBook")
    
    TapOn(.text("Add"))
    
    TapOn(.id("First name"))
    Input("John")
    
    TapOn(.id("Last name"))
    Input("Appleseed")
    
    TapOn(.text("Done"))
}
```

> [!TIP]
> In order to find the selectors to use for picking elements you can run `maestro studio` and click around to explore your app.

## Page Objects

It's common in UI testing to introduce Page Objects to share logic and hide away the details of knowing selectors ids.
In the above example knowing that the `Add` and `Done` buttons don't have ids but instead need looking up by `text` and that the text fields have `id`s is knowledge we want to share and not duplicate.
You can do this by creating `@Page`s to represent the different screens.
For the contacts app we have two screens - the `HomePage` and the `EditFormPage` so let's create those page objects

```swift
import MaestroDSL
import MaestroDSLMacro

@Page
struct HomePage {
    @FlowBuilder
    fileprivate func tapAdd() -> BasicFlow {
        TapOn(.text("Add"))
    }
}
```

> ![NOTE]
> This is totally using some funky macro magic which requires that your method be marked as `fileprivate` so that the macro can generate a stronger type to ensure we build flows in a page specific way.

The `EditFormPage` is more of the same

```swift
import MaestroDSL
import MaestroDSLMacro

@Page
struct EditFormPage {
    @FlowBuilder
    fileprivate func setFirstName(_ name: String) -> BasicFlow {
        TapOn(.id("First name"))
        Input(name)
    }

    @FlowBuilder
    fileprivate func setLastName(_ name: String) -> BasicFlow {
        TapOn(.id("Last name"))
        Input(name)
    }

    @FlowBuilder
    fileprivate func tapDone() -> BasicFlow {
        TapOn(.text("Done"))
    }
}
```

With these in place the original flow can now be expressed without mentioning identifiers

```swift
import MaestroDSL

try! maestroRun("com.apple.MobileAddressBook") {
    LaunchApp("com.apple.MobileAddressBook")
    
    HomePage {
        $0.tapAdd()
        
        EditFormPage {
            $0.setFirstName("John")
            $0.setLastName("Appleseed")
            $0.tapDone()
        }
    }
}
```

---

# Acknowledgements

Original ideas came from mobbing with [@adamcarter93](https://github.com/adamcarter93), [@ebent](https://github.com/ebent) and [@saadzulqarnain-at](https://github.com/saadzulqarnain-at)
