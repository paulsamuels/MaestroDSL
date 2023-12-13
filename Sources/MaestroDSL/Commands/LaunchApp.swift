import Foundation

public struct LaunchApp: Command {
    public let data: Any

    public init(
        _ bundleID: String,
        arguments: [String: Any]? = nil,
        clearKeychain: Bool? = nil,
        clearState: Bool? = nil,
        permissions: [String: String]? = nil,
        stopApp: Bool? = nil
    ) {
        data = [
            "launchApp": ([
                "appId": bundleID,
                "arguments": arguments,
                "clearKeychain": clearKeychain,
                "clearState": clearState,
                "permissions": permissions,
                "stopApp": stopApp,
            ] as [String: Any?]).compactMapValues { $0 },
        ]
    }
}
