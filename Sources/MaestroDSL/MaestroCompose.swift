import Foundation
import Yams

public func maestroCompose(_ bundleID: String, @FlowBuilder<Void> composition: () -> BasicFlow) throws -> String {
    try "appId: \(bundleID)\n---\n" + Yams.dump(object: composition().commands.map(\.data))
}
