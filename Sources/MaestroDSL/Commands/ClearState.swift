import Foundation

public struct ClearState: Command {
    public let data: Any

    public init(_ bundleID: String? = nil) {
        data = if let bundleID {
            ["clearState": bundleID]
        } else {
            "clearState"
        }
    }
}
