import MaestroDSL
import MaestroDSLMacro

@Page
struct HomePage {
    @FlowBuilder<HomePage>
    func tapAdd() -> Flow<HomePage> {
        TapOn(.text("Add"))
    }
}
