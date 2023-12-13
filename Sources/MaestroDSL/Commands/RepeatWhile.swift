import Foundation

public struct RepeatWhile: Command {
    public let data: Any

    public init(_ condition: Condition, @FlowBuilder<Void> commands: () -> BasicFlow) {
        data = [
            "repeat": [
                "while": condition.value,
                "commands": commands().commands.map(\.data),
            ],
        ]
    }
}
