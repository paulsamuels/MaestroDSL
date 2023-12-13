import Foundation

public struct SetLocation: Command {
    public let data: Any

    public init(latitude: String, longitude: String) {
        data = [
            "setLocation": [
                "latitude": latitude,
                "longitude": longitude,
            ],
        ]
    }
}
