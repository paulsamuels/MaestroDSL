import Foundation

public struct TakeScreenshot: Command {
    public let data: Any

    public init(_ name: String) {
        data = ["takeScreenshot": name]
    }
}
