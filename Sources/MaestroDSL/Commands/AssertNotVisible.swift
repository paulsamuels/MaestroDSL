import Foundation

public struct AssertNotVisible: Command {
    public let data: Any

    public init(_ selector: Selector) {
        data = ["assertNotVisible": selector.value]
    }
}
