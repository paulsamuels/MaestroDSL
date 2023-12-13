import MaestroDSL
import MaestroDSLMacro

@Page
struct HomePage {
    @FlowBuilder
    fileprivate func tapAdd() -> BasicFlow {
        TapOn(.text("Add"))
    }
}
