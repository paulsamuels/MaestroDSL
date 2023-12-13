import MacroTesting
import MaestroDSLMacroMacros
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class MaestroDSLMacroTests: XCTestCase {
    override func invokeTest() {
        withMacroTesting(macros: [PageMacro.self]) {
            super.invokeTest()
        }
    }

    func testEnumIsNotSupported() throws {
        assertMacro {
            """
            @Page
            enum ExamplePage { }
            """
        } diagnostics: {
            """
            @Page
            ╰─ 🛑 @Page can only be applied to a struct
            enum ExamplePage { }
            """
        }
    }

    func testClassIsNotSupported() throws {
        assertMacro {
            """
            @Page
            class ExamplePage { }
            """
        } diagnostics: {
            """
            @Page
            ╰─ 🛑 @Page can only be applied to a struct
            class ExamplePage { }
            """
        }
    }

    func testWhenNoInitIsProvidedADefaultIsAdded() throws {
        assertMacro {
            """
            @Page
            struct ExamplePage { }
            """
        } expansion: {
            """
            struct ExamplePage { 

                var commands: [any Command] = []}

            extension ExamplePage: Page {
                init(@PageBuilder<ExamplePage> content: @escaping (ExamplePage) -> Flow<ExamplePage>) {
                    self.commands = content(self).commands
                }
            }
            """
        }
    }

    func testWhenInitIsProvidedIsMustBeFilePrivate() throws {
        assertMacro {
            """
            @Page
            struct ExamplePage { 
                init(example: String) {
                    print(example)
                }
            }
            """
        } diagnostics: {
            """
            @Page
            struct ExamplePage { 
                init(example: String) {
                ╰─ 🛑 @Page only supports inits/functions that are marked as fileprivate to ensure correct instantiation
                    print(example)
                }
            }
            """
        }
    }

    func testWhenInitIsProvidedAnOverrideIsAdded() throws {
        assertMacro {
            """
            @Page
            struct ExamplePage {
                fileprivate init(example: String) {
                    print(example)
                }
            }
            """
        } expansion: {
            """
            struct ExamplePage {
                fileprivate init(example: String) {
                    print(example)
                }

                var commands: [any Command] = []
            }

            extension ExamplePage: Page {
                init(example: String, @PageBuilder<ExamplePage> content: @escaping (ExamplePage) -> Flow<ExamplePage>) {
                        print(example)
                        self.commands = content(self).commands
                    }
            }
            """
        }
    }

    func testWhenFlowBuilderIsProvidedIsMustBeFilePrivate() throws {
        assertMacro {
            """
            @Page
            struct ExamplePage {
                @FlowBuilder
                func tap() -> any Flow {
                    Tap(.id("example"))
                }
            }
            """
        } diagnostics: {
            """
            @Page
            struct ExamplePage {
                @FlowBuilder
                func tap() -> any Flow {
                        ┬─────────────
                        ╰─ 🛑 @Page only supports inits/functions that are marked as fileprivate to ensure correct instantiation
                    Tap(.id("example"))
                }
            }
            """
        }
    }

    func testWhenFlowBuilderIsProvidedAnOverrideIsAdded() throws {
        assertMacro {
            """
            @Page
            struct ExamplePage {
                @FlowBuilder
                fileprivate func tap() -> any Flow {
                    Tap(.id("example"))
                }
            }
            """
        } expansion: {
            """
            struct ExamplePage {
                @FlowBuilder
                fileprivate func tap() -> any Flow {
                    Tap(.id("example"))
                }

                var commands: [any Command] = []
            }

            extension ExamplePage: Page {
                init(@PageBuilder<ExamplePage> content: @escaping (ExamplePage) -> Flow<ExamplePage>) {
                    self.commands = content(self).commands
                }
                func tap() -> Flow<ExamplePage> {
                    invokeOriginalFlowErasingType(function: tap)
                    }
            }
            """
        }
    }
}
