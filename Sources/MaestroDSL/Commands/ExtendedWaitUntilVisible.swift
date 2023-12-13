import Foundation

public struct ExtendedWaitUntilVisible: Command {
    public let data: Any

    public init(_ selector: Selector, timeout: Int? = nil) {
        data = [
            "extendedWaitUntil": ["visible": selector.value].merging(
                (["timeout": timeout] as [String: Any?]).compactMapValues { $0 }
            ) { $1 },
        ]
    }
}
