import Foundation

public struct Flow<T> {
    public let commands: [any Command]

    init(_ command: Command) {
        commands = [command]
    }

    init(_ commands: [Command]) {
        self.commands = commands
    }

    init(_ flow: Flow?) {
        commands = flow?.commands ?? []
    }

    init(_ flows: [Flow]) {
        commands = flows.flatMap(\.commands)
    }

    init(_ page: Page) {
        commands = page.commands
    }
}
