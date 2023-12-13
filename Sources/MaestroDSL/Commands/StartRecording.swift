import Foundation

public struct StartRecording: Command {
    public let data: Any

    public init(_ name: String) {
        data = ["startRecording": name]
    }
}
