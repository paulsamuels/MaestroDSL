import MaestroDSL

@attached(extension, conformances: Page, names: arbitrary)
@attached(member, names: named(commands))
public macro Page() = #externalMacro(module: "MaestroDSLMacroMacros", type: "PageMacro")
