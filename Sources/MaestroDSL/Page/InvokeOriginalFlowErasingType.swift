import Foundation

 public func invokeOriginalFlowErasingType<each Arg, Tag: Page>(function: @escaping (repeat each Arg) -> BasicFlow, _ args: repeat each Arg) -> Flow<Tag> {
     .init((function as (repeat each Arg) -> Flow)(repeat each args).commands)
 }
