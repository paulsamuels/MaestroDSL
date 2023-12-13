import Foundation

public struct CopyTextFrom: Command {
    public let data: Any

    public init(_ selector: Selector) {
        data = ["copyTextFrom": selector.value]
    }
}
