import Foundation

public struct Input: Command {
    public let data: Any

    public init(random kind: Kind) {
        data = "inputRandom\(kind.rawValue)"
    }

    public init(_ text: String) {
        data = ["inputText": text]
    }

    public enum Kind: String {
        case email = "Email"
        case number = "Number"
        case personName = "PersonName"
        case text = "Text"
    }
}
