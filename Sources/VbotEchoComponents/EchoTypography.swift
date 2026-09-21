import CoreText
import SwiftUI

/// Same face and Dynamic Type baseline as VCApp's AppFont.bodyMedium.
enum EchoTypography {
    private static let registerFont: Void = {
        let url = Bundle.module.url(forResource: "Vbot-Sans-Medium", withExtension: "ttf")!
        // Registration can return false when the host already registered this same font.
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }()

    static var button: Font {
        _ = registerFont
        return .custom("Vbot-Sans-Medium", size: 16, relativeTo: .body)
    }
}
