import Foundation

@resultBuilder
public enum FlowBuilder<T> {
    public static func buildExpression(_ expression: Page) -> Flow<T> {
        .init(expression.commands)
    }

    public static func buildExpression(_ expression: Flow<T>) -> Flow<T> {
        expression
    }

    public static func buildExpression(_ expression: any Command) -> Flow<T> {
        .init(expression)
    }

    public static func buildBlock(_ components: Flow<T>...) -> Flow<T> {
        .init(components)
    }

    public static func buildArray(_ components: [Flow<T>]) -> Flow<T> {
        .init(components)
    }

    public static func buildOptional(_ component: Flow<T>?) -> Flow<T> {
        Flow(component)
    }

    public static func buildEither(first component: Flow<T>) -> Flow<T> {
        component
    }

    public static func buildEither(second component: Flow<T>) -> Flow<T> {
        component
    }
}
