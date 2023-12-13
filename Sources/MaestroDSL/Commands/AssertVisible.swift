import Foundation

public struct AssertVisible: Command {
    public let data: Any

    public init(_ selector: Selector) {
        data = ["assertVisible": selector.value]
    }
}
