import SwiftUI

public enum AppFont {
    // Replace this with your font's PostScript name (e.g., "Inter-Regular" or the family variant you want as default)
    public static let name: String = "CaacupeOne-Regular"
    // Default base size used when injecting the environment font
    public static let baseSize: CGFloat = 16
}

public extension Font {
    static func app(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        // Weight variants require separate font files; if you have them, you can map weights to specific PostScript names.
        // For now, this returns the base custom font at the requested size.
        .custom(AppFont.name, size: size)
    }

    static var appDefault: Font { .custom(AppFont.name, size: AppFont.baseSize) }
}
