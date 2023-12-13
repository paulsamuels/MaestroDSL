import Foundation
import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct PageMacro: ExtensionMacro, MemberMacro {
    public static func expansion<Declaration: SwiftSyntax.DeclGroupSyntax>(
        of _: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: Declaration,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo _: [SwiftSyntax.TypeSyntax],
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        var hasCustomInit = false
        let decls = declaration.memberBlock.members.as(MemberBlockItemListSyntax.self).flatMap {
            $0.compactMap {
                if
                    let function = $0.decl.as(FunctionDeclSyntax.self),
                    function.attributes.contains(where: { $0.as(AttributeSyntax.self)?.attributeName.as(IdentifierTypeSyntax.self)?.name.text == "FlowBuilder" })
                {
                    return makePageFlowFunction(context: context, type: type, function: function)
                } else if let initializer = $0.decl.as(InitializerDeclSyntax.self) {
                    hasCustomInit = true
                    return makeBuilderInitializer(context: context, type: type, initializer: initializer)
                } else {
                    return nil
                }
            }
        } ?? [DeclSyntaxProtocol]()

        var decl = ("""
        extension \(type.trimmed): Page {}
        """ as DeclSyntax).as(ExtensionDeclSyntax.self)!

        if !hasCustomInit {
            decl.memberBlock.members.append(MemberBlockItemSyntax(decl: makeDefaultBuilderInitializer(type: type)))
        }

        decl.memberBlock.members.append(contentsOf: decls.compactMap { MemberBlockItemSyntax(decl: $0) })

        return [decl]
    }

    private static func makeBuilderInitializer(
        context: some SwiftSyntaxMacros.MacroExpansionContext,
        type: some SwiftSyntax.TypeSyntaxProtocol,
        initializer: InitializerDeclSyntax
    ) -> InitializerDeclSyntax? {
        guard initializer.modifiers.contains(where: { $0.name.text == "fileprivate" }) else {
            context.diagnose(.init(node: initializer, message: MaestroError.functionsMustBeFilePrivate))
            return nil
        }

        var mutableInitializer = initializer
        mutableInitializer.modifiers = mutableInitializer.modifiers.filter { $0.name.text != "fileprivate" }

        var isFirst = true
        mutableInitializer.signature.parameterClause.parameters = .init(
            mutableInitializer.signature.parameterClause.parameters.reversed().map { functionParameter -> FunctionParameterSyntax in
                if isFirst {
                    isFirst = false
                    var mutableThing = functionParameter
                    mutableThing.trailingComma = .commaToken(trailingTrivia: " ")
                    return mutableThing
                } else {
                    return functionParameter
                }
            }.reversed()
        )

        mutableInitializer.signature.parameterClause.parameters.append("@PageBuilder<\(type.trimmed)> content: @escaping (\(type.trimmed)) -> Flow<\(type.trimmed)>")
        mutableInitializer.body?.statements.append("self.commands = content(self).commands")
        return mutableInitializer
    }

    private static func makeDefaultBuilderInitializer(type: some SwiftSyntax.TypeSyntaxProtocol) -> DeclSyntax {
        """
        init(@PageBuilder<\(type.trimmed)> content: @escaping (\(type.trimmed)) -> Flow<\(type.trimmed)>) {
            self.commands = content(self).commands
        }


        """
    }

    private static func makePageFlowFunction(
        context: some SwiftSyntaxMacros.MacroExpansionContext,
        type: some SwiftSyntax.TypeSyntaxProtocol,
        function: FunctionDeclSyntax
    ) -> FunctionDeclSyntax? {
        guard function.modifiers.contains(where: { $0.name.text == "fileprivate" }) else {
            context.diagnose(.init(node: function.signature, message: MaestroError.functionsMustBeFilePrivate))
            return nil
        }

        var mutableFunction = function
        mutableFunction.attributes = []
        mutableFunction.modifiers = mutableFunction.modifiers.filter { $0.name.text != "fileprivate" }
        mutableFunction.signature.returnClause = ReturnClauseSyntax(type: try! TypeSyntax(validating: "Flow<\(type.trimmed)>"))

        let parameters = ([function.name.trimmed.text] + function.signature.parameterClause.parameters.map { ($0.secondName ?? $0.firstName).text }).joined(separator: ", ")
        let formattedParameters = parameters.isEmpty ? "" : "\(parameters)"
        mutableFunction.body?.statements = "invokeOriginalFlowErasingType(function: \(raw: formattedParameters))"
        return mutableFunction
    }

    public static func expansion<Declaration: SwiftSyntax.DeclGroupSyntax>(
        of _: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: Declaration,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) -> [SwiftSyntax.DeclSyntax] {
        guard let _ = declaration.as(StructDeclSyntax.self) else {
            context.diagnose(.init(node: declaration, message: MaestroError.onlyApplicableToStructs))
            return []
        }

        return ["var commands: [any Command] = []"]
    }
}

enum MaestroError: DiagnosticMessage {
    var diagnosticID: SwiftDiagnostics.MessageID {
        .init(domain: "maestro-dsl", id: message)
    }

    var severity: SwiftDiagnostics.DiagnosticSeverity {
        .error
    }

    case onlyApplicableToStructs
    case functionsMustBeFilePrivate

    var message: String {
        switch self {
        case .functionsMustBeFilePrivate:
            "@Page only supports inits/functions that are marked as fileprivate to ensure correct instantiation"
        case .onlyApplicableToStructs:
            "@Page can only be applied to a struct"
        }
    }
}

@main
struct MaestroDSLMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [PageMacro.self]
}
