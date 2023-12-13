import Foundation

public struct DoubleTapOn: Command {
    public let data: Any

    public init(_ selector: Selector, repeat: Int? = nil, delay: Int? = nil, waitToSettleTimeoutMs: Int? = nil) {
        data = [
            "doubleTapOn": selector.value.merging(
                ([
                    "repeat": `repeat`,
                    "delay": delay,
                    "waitToSettleTimeoutMs": waitToSettleTimeoutMs,
                ] as [String: Any?]).compactMapValues { $0 }
            ) { $1 },
        ]
    }
}
