import Foundation

public struct AssertTrue: Command {
    public let data: Any

    public init(_ script: String) {
        data = ["assertTrue": "${\(script)}"]
    }
}
