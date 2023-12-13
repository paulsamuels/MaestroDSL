import Foundation

@resultBuilder
public enum FlowBuilder {
    public static func buildExpression(_ expression: Page) -> BasicFlow {
        .init(expression.commands)
    }

    public static func buildExpression(_ expression: BasicFlow) -> BasicFlow {
        expression
    }

    public static func buildExpression(_ expression: any Command) -> BasicFlow {
        .init(expression)
    }

    public static func buildBlock(_ components: BasicFlow...) -> BasicFlow {
        .init(components)
    }

    public static func buildArray(_ components: [BasicFlow]) -> BasicFlow {
        .init(components)
    }

    public static func buildOptional(_ component: BasicFlow?) -> BasicFlow {
        Flow(component)
    }

    public static func buildEither(first component: BasicFlow) -> BasicFlow {
        component
    }

    public static func buildEither(second component: BasicFlow) -> BasicFlow {
        component
    }
}
