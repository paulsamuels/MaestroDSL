import Foundation

public struct Condition {
    let value: Any

    public static func notVisible(_ selector: Selector) -> Condition {
        .init(value: ["notVisible": selector.value])
    }

    public static func platform(_ platform: Platform) -> Condition {
        .init(value: ["platform": platform.rawValue])
    }

    public static func `true`(_ script: String) -> Condition {
        .init(value: ["true": "${\(script)}"])
    }

    public static func visible(_ selector: Selector) -> Condition {
        .init(value: ["visible": selector.value])
    }

    public enum Platform: String {
        case android = "Android"
        case iOS
    }
}
