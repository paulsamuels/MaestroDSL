import Foundation

public struct ScrollUntilVisible: Command {
    public let data: Any

    public init(
        _ selector: Selector,
        direction: Direction? = nil,
        timeout: Int? = nil,
        speed: Int? = nil,
        visibilityPercentage: Int? = nil,
        centerElement: Bool? = nil
    ) {
        data = [
            "scrollUntilVisible": ([
                "centerElement": centerElement,
                "direction": direction?.rawValue,
                "element": selector.value,
                "speed": speed,
                "timeout": timeout,
                "visibilityPercentage": visibilityPercentage,
            ] as [String: Any?]).compactMapValues { $0 },
        ]
    }
}
