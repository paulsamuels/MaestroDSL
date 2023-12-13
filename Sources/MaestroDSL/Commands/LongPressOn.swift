import Foundation

public struct LongPressOn: Command {
    public let data: Any

    public init(_ selector: Selector, repeat: Int? = nil, delay: Int? = nil, waitToSettleTimeoutMs: Int? = nil) {
        data = [
            "longPressOn": selector.value.merging(
                ([
                    "repeat": `repeat`,
                    "delay": delay,
                    "waitToSettleTimeoutMs": waitToSettleTimeoutMs,
                ] as [String: Any?]).compactMapValues { $0 }
            ) { $1 },
        ]
    }
}
