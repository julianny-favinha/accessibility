import Foundation
import UIKit

public enum FontSulSansStyle: String {
    case bold
    case light
    case medium
    case regular

    func fontName() -> String {
        switch self {
        case .regular:
            return "SulSans-Regular"
        case .bold:
            return "SulSans-Bold"
        case .light:
            return "SulSans-Light"
        case .medium:
            return "SulSans-Medium"
        }
    }

    func fontFilename() -> String {
        switch self {
        case .regular:
            return "Sul Sans Regular"
        case .bold:
            return "Sul Sans Bold"
        case .light:
            return "Sul Sans Light"
        case .medium:
            return "Sul Sans Medium"
        }
    }

    func fontFamilyName() -> String {
        return "Sul Sans"
    }
}

#if arch(arm64) || arch(x86_64)
import SwiftUI

@available(iOS 13.0, *)
public extension Font {
    static func sulSans(textStyle: UIFont.TextStyle, fontStyle: FontSulSansStyle) -> Font {
        loadFontSulSans(ofStyle: fontStyle)
        let pointSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).pointSize
        return Font.custom(fontStyle.fontName(), size: pointSize)
    }

    static func loadFontSulSans(ofStyle style: FontSulSansStyle) {
        if UIFont.fontNames(forFamilyName: style.fontFamilyName()).contains(style.fontName()) {
            return
        }

        FontLoader.loadFont(style.fontFilename())
    }
}
#endif

public extension UIFont {
    class func fontSulSans(textStyle: UIFont.TextStyle, fontStyle: FontSulSansStyle) -> UIFont {
        loadFontSulSans(ofStyle: fontStyle)
        let pointSize = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).pointSize
        return UIFont(name: fontStyle.fontName(), size: pointSize) ?? UIFont(descriptor: UIFontDescriptor(name: fontStyle.fontName(), size: pointSize), size: pointSize)
    }

    /// Loads the Sul Sans font in to memory.
    /// This method should be called when setting icons without using code.
    class func loadFontSulSans(ofStyle style: FontSulSansStyle) {
        if UIFont.fontNames(forFamilyName: style.fontFamilyName()).contains(style.fontName()) {
            return
        }

        FontLoader.loadFont(style.fontFilename())
    }
}

// MARK: - Private

private class FontLoader {
    class func loadFont(_ name: String) {
        guard
            let fontURL = URL.fontURL(for: name),
            let data = try? Data(contentsOf: fontURL),
            let provider = CGDataProvider(data: data as CFData),
            let font = CGFont(provider)
        else {
            return
        }

        var error: Unmanaged<CFError>?

        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            guard let errorTakeUnretainedValue = error?.takeUnretainedValue() else { return }
            let errorDescription: CFString = CFErrorCopyDescription(errorTakeUnretainedValue)
            guard let nsError = error?.takeUnretainedValue() as AnyObject as? NSError else { return }
            NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }
}

extension URL {
    static func fontURL(for fontName: String) -> URL? {
        let bundle = Bundle(for: FontLoader.self)

        if let fontURL = bundle.url(forResource: fontName, withExtension: "otf") {
            return fontURL
        }

        // If this framework is added using CocoaPods, resources is placed under a subdirectory

        if let fontURL = bundle.url(forResource: fontName, withExtension: "otf", subdirectory: "FontSulSans.bundle") {
            return fontURL
        }

        return nil
    }
}
