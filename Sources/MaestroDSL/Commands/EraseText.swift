import Foundation

public struct EraseText: Command {
    public let data: Any

    public init(_ characterCount: Int? = nil) {
        data = if let characterCount {
            ["eraseText": characterCount]
        } else {
            "eraseText"
        }
    }
}
