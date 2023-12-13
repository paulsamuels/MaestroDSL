import Foundation
import Yams

public func maestroRun(_ bundleID: String, @FlowBuilder<Void> composition: () -> BasicFlow) throws {
    let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("commands.yaml")

    try maestroCompose(bundleID, composition: composition).write(
        to: fileURL,
        atomically: true,
        encoding: .utf8
    )

    let process = try Process.run(
        FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".maestro/bin/maestro"),
        arguments: ["test", fileURL.path]
    )
    process.waitUntilExit()
}
