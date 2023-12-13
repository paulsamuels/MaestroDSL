import Foundation

public struct WaitForAnimationToEnd: Command {
    public let data: Any

    public init(_ timeout: Int? = nil) {
        data = if let timeout {
            ["waitForAnimationToEnd": timeout]
        } else {
            "waitForAnimationToEnd"
        }
    }
}
