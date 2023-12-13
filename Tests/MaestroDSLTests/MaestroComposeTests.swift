import MaestroDSL
import XCTest

final class MaestroComposeTests: XCTestCase {
    func testFlowsCreateTheCorrectJsonFragments() throws {
        for fixture in fixtures {
            let result = try maestroCompose("com.example") {
                fixture.flow
            }

            XCTAssertEqual(result, "appId: com.example\n---\n\(fixture.expected)\n", line: fixture.line)
        }
    }

    let fixtures = [
        fixtureOf(
            """
            - addMedia:
              - image1
              - image2
            """
        ) { AddMedia("image1", "image2") },

        fixtureOf(
            """
            - assertNotVisible:
                index: 4
                text: label
            - assertNotVisible:
                id: my-id
            - assertNotVisible:
                checked: false
                enabled: true
                focused: false
                id: my-id
                optional: true
                selected: false
            """
        ) {
            AssertNotVisible(.text("label", index: 4))
            AssertNotVisible(.id("my-id"))
            AssertNotVisible(.id("my-id", checked: false, enabled: true, focused: false, optional: true, selected: false))
        },

        fixtureOf(
            """
            - assertTrue: ${output.viewA == maestro.copiedText}
            """
        ) {
            AssertTrue("output.viewA == maestro.copiedText")
        },

        fixtureOf(
            """
            - assertVisible:
                index: 4
                text: label
            - assertVisible:
                id: my-id
            - assertVisible:
                checked: false
                enabled: true
                focused: false
                id: my-id
                optional: true
                selected: false
            """
        ) {
            AssertVisible(.text("label", index: 4))
            AssertVisible(.id("my-id"))
            AssertVisible(.id("my-id", checked: false, enabled: true, focused: false, optional: true, selected: false))
        },

        fixtureOf("- back") { Back() },
        fixtureOf("- clearKeychain") { ClearKeychain() },
        fixtureOf("- clearState") { ClearState() },
        fixtureOf("- clearState: com.other.app") { ClearState("com.other.app") },

        fixtureOf(
            """
            - copyTextFrom:
                index: 4
                text: label
            - copyTextFrom:
                id: my-id
            """
        ) {
            CopyTextFrom(.text("label", index: 4))
            CopyTextFrom(.id("my-id"))
        },

        fixtureOf(
            """
            - doubleTapOn:
                index: 4
                text: label
            - doubleTapOn:
                id: my-id
            """
        ) {
            DoubleTapOn(.text("label", index: 4))
            DoubleTapOn(.id("my-id"))
        },

        fixtureOf("- eraseText") { EraseText() },
        fixtureOf("- eraseText: 200") { EraseText(200) },
        fixtureOf("- evalScript: ${output.myFlow = MY_NAME.toUpperCase()}") { EvalScript("output.myFlow = MY_NAME.toUpperCase()") },

        fixtureOf(
            """
            - extendedWaitUntil:
                notVisible:
                  text: label
                timeout: 10000
            - extendedWaitUntil:
                notVisible:
                  id: my-id
                timeout: 10000
            """
        ) {
            ExtendedWaitUntilNotVisible(.text("label"), timeout: 10000)
            ExtendedWaitUntilNotVisible(.id("my-id"), timeout: 10000)
        },

        fixtureOf(
            """
            - extendedWaitUntil:
                timeout: 10000
                visible:
                  text: label
            - extendedWaitUntil:
                timeout: 10000
                visible:
                  id: my-id
            """
        ) {
            ExtendedWaitUntilVisible(.text("label"), timeout: 10000)
            ExtendedWaitUntilVisible(.id("my-id"), timeout: 10000)
        },

        fixtureOf("- hideKeyboard") { HideKeyboard() },
        fixtureOf("- inputText: example") { Input("example") },
        fixtureOf("- inputRandomEmail") { Input(random: .email) },
        fixtureOf("- inputRandomNumber") { Input(random: .number) },
        fixtureOf("- inputRandomPersonName") { Input(random: .personName) },
        fixtureOf("- inputRandomText") { Input(random: .text) },

        fixtureOf(
            """
            - launchApp:
                appId: com.example.app
                arguments:
                  example: true
                  other: name
                clearKeychain: true
                clearState: true
                permissions:
                  all: deny
                stopApp: false
            """
        ) {
            LaunchApp(
                "com.example.app",
                arguments: [
                    "example": true,
                    "other": "name",
                ],
                clearKeychain: true,
                clearState: true,
                permissions: [
                    "all": "deny",
                ],
                stopApp: false
            )
        },

        fixtureOf(
            """
            - openLink:
                link: https://example.com
            - openLink:
                autoVerify: false
                link: https://example.com
            - openLink:
                browser: false
                link: https://example.com
            """
        ) {
            OpenLink("https://example.com")
            OpenLink("https://example.com", autoVerify: false)
            OpenLink("https://example.com", browser: false)
        },

        fixtureOf("- pasteText") { PasteText() },

        fixtureOf(
            """
            - pressKey: Back
            - pressKey: Backspace
            - pressKey: Enter
            - pressKey: Home
            - pressKey: Lock
            - pressKey: Power
            - pressKey: Volume down
            - pressKey: Volume up
            """
        ) {
            PressKey(.back)
            PressKey(.backspace)
            PressKey(.enter)
            PressKey(.home)
            PressKey(.lock)
            PressKey(.power)
            PressKey(.volumeDown)
            PressKey(.volumeUp)
        },

        fixtureOf(
            """
            - repeat:
                commands:
                - stopApp
                while:
                  platform: iOS
            """
        ) {
            RepeatWhile(.platform(.iOS)) {
                StopApp()
            }
        },

        fixtureOf(
            """
            - runFlow:
                commands:
                - stopApp
                when:
                  platform: iOS
            """
        ) {
            RunFlow(.platform(.iOS)) {
                StopApp()
            }
        },

        fixtureOf("- scroll") { Scroll() },

        fixtureOf(
            """
            - scrollUntilVisible:
                centerElement: false
                direction: Down
                element:
                  id: viewId
                speed: 40
                timeout: 50000
                visibilityPercentage: 100
            """
        ) {
            ScrollUntilVisible(
                .id("viewId"),
                direction: .down,
                timeout: 50000,
                speed: 40,
                visibilityPercentage: 100,
                centerElement: false
            )
        },

        fixtureOf(
            """
            - setLocation:
                latitude: '52.3599976'
                longitude: '4.8830301'
            """
        ) { SetLocation(latitude: "52.3599976", longitude: "4.8830301") },

        fixtureOf("- startRecording: myRecording") { StartRecording("myRecording") },
        fixtureOf("- stopApp") { StopApp() },
        fixtureOf("- stopApp: other.app") { StopApp("other.app") },
        fixtureOf("- stopRecording") { StopRecording() },

        fixtureOf(
            """
            - swipe:
                end: 10%, 50%
                start: 90%, 50%
            - swipe:
                direction: LEFT
                duration: 2000
            """
        ) {
            Swipe(startX: "90%", startY: "50%", endX: "10%", endY: "50%")
            Swipe(direction: .left, duration: 2000)
        },

        fixtureOf("- takeScreenshot: MainScreen") { TakeScreenshot("MainScreen") },

        fixtureOf(
            """
            - tapOn:
                index: 4
                text: label
            - tapOn:
                id: my-id
            """
        ) {
            TapOn(.text("label", index: 4))
            TapOn(.id("my-id"))
        },

        fixtureOf("- waitForAnimationToEnd") { WaitForAnimationToEnd() },
        fixtureOf("- waitForAnimationToEnd: 5000") { WaitForAnimationToEnd(5000) },
    ]
}

private func fixtureOf(_ expected: String, line: UInt = #line, @FlowBuilder build: () -> BasicFlow) -> Fixture {
    .init(expected: expected, flow: build(), line: line)
}

struct Fixture {
    let expected: String
    let flow: BasicFlow
    let line: UInt
}
