import Foundation

public struct StopApp: Command {
    public let data: Any

    public init(_ bundleID: String? = nil) {
        data = if let bundleID {
            ["stopApp": bundleID]
        } else {
            "stopApp"
        }
    }
}
