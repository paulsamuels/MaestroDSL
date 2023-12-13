import Foundation

public struct OpenLink: Command {
    public let data: Any

    public init(_ link: String, autoVerify: Bool? = nil, browser: Bool? = nil) {
        data = [
            "openLink": (
                [
                    "link": link,
                    "autoVerify": autoVerify,
                    "browser": browser,
                ] as [String: Any?]
            ).compactMapValues { $0 },
        ]
    }
}
