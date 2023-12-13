import Foundation

public struct AddMedia: Command {
    public let data: Any

    public init(_ paths: String...) {
        data = ["addMedia": paths]
    }
}
