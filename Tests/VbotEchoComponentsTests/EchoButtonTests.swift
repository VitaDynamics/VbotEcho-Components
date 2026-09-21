import XCTest
@testable import VbotEchoComponents

final class EchoButtonTests: XCTestCase {
    func testAllVariantsResolveInteractionAndDesignTokens() {
        for context in EchoButton.Context.allCases {
            let prefix = context == .media ? "echo-action-on-media" : "echo-action"
            for role in EchoButton.Role.allCases {
                for state in EchoButton.State.allCases {
                    let button = EchoButton("Continue", loadingLabel: "Working", role: role,
                                            context: context, state: state) {}
                    XCTAssertEqual(button.acceptsInput, state == .default || state == .pressed)
                    let appearance = button.appearance(isEnabled: true, isPressed: false)
                    let inactive = state == .disabled || state == .loading
                    let roleName = role.rawValue
                    XCTAssertEqual(appearance.background,
                                   "\(prefix)-\(inactive ? "disabled-background" : roleName + (state == .pressed ? "-pressed" : "-background"))")
                    XCTAssertEqual(appearance.foreground,
                                   "\(prefix)-\(inactive ? "disabled" : roleName)-label")
                }
            }
        }
    }

    func testEnvironmentDisabledAndNativePressTakePrecedence() {
        let button = EchoButton("Continue") {}
        XCTAssertEqual(button.appearance(isEnabled: true, isPressed: true).background,
                       "echo-action-primary-pressed")
        XCTAssertEqual(button.appearance(isEnabled: false, isPressed: true).background,
                       "echo-action-disabled-background")
    }
}
