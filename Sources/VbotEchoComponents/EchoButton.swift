import SwiftUI

/// Figma Echo / Button. Strings are already localized by the calling app.
public struct EchoButton: View {
    public enum Role: String, CaseIterable { case primary, secondary, ghost }
    public enum Context: CaseIterable { case surface, media }
    public enum State: CaseIterable { case `default`, pressed, disabled, loading }

    let title: String
    let loadingLabel: String
    let role: Role
    let context: Context
    let state: State
    private let action: () -> Void

    public init(_ title: String, loadingLabel: String? = nil, role: Role = .primary,
                context: Context = .surface, state: State = .default,
                action: @escaping () -> Void) {
        self.title = title
        self.loadingLabel = loadingLabel ?? String(localized: "button.loading", bundle: .module)
        self.role = role
        self.context = context
        self.state = state
        self.action = action
    }

    var acceptsInput: Bool { state != .disabled && state != .loading }

    func appearance(isEnabled: Bool, isPressed: Bool) -> (background: String, foreground: String) {
        let prefix = context == .media ? "echo-action-on-media" : "echo-action"
        if !isEnabled || !acceptsInput {
            return ("\(prefix)-disabled-background", "\(prefix)-disabled-label")
        }
        let background = isPressed || state == .pressed ? "pressed" : "background"
        return ("\(prefix)-\(role.rawValue)-\(background)", "\(prefix)-\(role.rawValue)-label")
    }

    public var body: some View {
        Button(action: action) {
            Text(verbatim: state == .loading ? loadingLabel : title)
                .font(EchoTypography.button)
                .multilineTextAlignment(.center)
        }
        .buttonStyle(Style(button: self))
        .disabled(!acceptsInput)
    }

    private struct Style: ButtonStyle {
        let button: EchoButton
        @Environment(\.isEnabled) private var isEnabled
        @ScaledMetric(relativeTo: .body) private var height = 52.0
        @ScaledMetric(relativeTo: .body) private var lineHeight = 24.0

        func makeBody(configuration: Configuration) -> some View {
            let colors = button.appearance(isEnabled: isEnabled, isPressed: configuration.isPressed)
            configuration.label
                .frame(minHeight: lineHeight)
                .padding(.horizontal, 24)
                .padding(.vertical, (height - lineHeight) / 2)
                .frame(maxWidth: .infinity, minHeight: height)
                .foregroundStyle(Color(colors.foreground, bundle: .module))
                .background(Color(colors.background, bundle: .module), in: Capsule())
                .contentShape(Capsule())
        }
    }
}
