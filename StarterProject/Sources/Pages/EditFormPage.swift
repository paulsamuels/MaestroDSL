import MaestroDSL
import MaestroDSLMacro

@Page
struct EditFormPage {
    @FlowBuilder<EditFormPage>
    func setFirstName(_ name: String) -> Flow<EditFormPage> {
        TapOn(.id("First name"))
        Input(name)
    }

    @FlowBuilder<EditFormPage>
    func setLastName(_ name: String) -> Flow<EditFormPage> {
        TapOn(.id("Last name"))
        Input(name)
    }

    @FlowBuilder<EditFormPage>
    func tapDone() -> Flow<EditFormPage> {
        TapOn(.text("Done"))
    }
}
