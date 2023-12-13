import Foundation

public struct PressKey: Command {
    public let data: Any

    public init(_ key: Key) {
        data = ["pressKey": key.rawValue]
    }

    public enum Key: String {
        case back = "Back"
        case backspace = "Backspace"
        case enter = "Enter"
        case home = "Home"
        case lock = "Lock"
        case power = "Power"
        case volumeDown = "Volume down"
        case volumeUp = "Volume up"
    }
}
