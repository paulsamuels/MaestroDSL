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
