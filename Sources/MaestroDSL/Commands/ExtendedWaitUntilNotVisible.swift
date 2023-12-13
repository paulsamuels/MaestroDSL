import Foundation

public struct ExtendedWaitUntilNotVisible: Command {
    public let data: Any

    public init(_ selector: Selector, timeout: Int? = nil) {
        data = [
            "extendedWaitUntil": ["notVisible": selector.value].merging(
                (["timeout": timeout] as [String: Any?]).compactMapValues { $0 }
            ) { $1 },
        ]
    }
}
