import Foundation

public struct EvalScript: Command {
    public let data: Any

    public init(_ script: String) {
        data = ["evalScript": "${\(script)}"]
    }
}
