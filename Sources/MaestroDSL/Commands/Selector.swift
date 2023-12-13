import Foundation

public struct Selector {
    let value: [String: Any?]

    public static func id(
        _ id: String,
        checked: Bool? = nil,
        enabled: Bool? = nil,
        focused: Bool? = nil,
        optional: Bool? = nil,
        selected: Bool? = nil
    ) -> Selector {
        .init(
            value: ([
                "checked": checked,
                "enabled": enabled,
                "focused": focused,
                "id": id,
                "optional": optional,
                "selected": selected,
            ] as [String: Any?]).compactMapValues { $0 }
        )
    }

    public static func text(
        _ text: String,
        index: Int? = nil,
        checked: Bool? = nil,
        enabled: Bool? = nil,
        focused: Bool? = nil,
        optional: Bool? = nil,
        selected: Bool? = nil
    ) -> Selector {
        .init(
            value: ([
                "checked": checked,
                "enabled": enabled,
                "focused": focused,
                "index": index,
                "optional": optional,
                "selected": selected,
                "text": text,
            ] as [String: Any?]).compactMapValues { $0 }
        )
    }
}
