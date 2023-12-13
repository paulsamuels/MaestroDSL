import Foundation

public struct RunFlow: Command {
    public let data: Any

    public init(_ condition: Condition, @FlowBuilder<Void> commands: () -> BasicFlow) {
        data = [
            "runFlow": [
                "when": condition.value,
                "commands": commands().commands.map(\.data),
            ],
        ]
    }
}
