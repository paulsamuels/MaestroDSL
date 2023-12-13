import Foundation

public struct Swipe: Command {
    public let data: Any

    public init(direction: Direction, duration: Int? = nil) {
        data = [
            "swipe": ([
                "direction": direction.rawValue.uppercased(),
                "duration": duration,
            ] as [String: Any?]).compactMapValues { $0 },
        ]
    }

    public init(startX: String, startY: String, endX: String, endY: String, duration: Int? = nil) {
        data = [
            "swipe": ([
                "start": "\(startX), \(startY)",
                "end": "\(endX), \(endY)",
                "duration": duration,
            ] as [String: Any?]).compactMapValues { $0 },
        ]
    }
}
