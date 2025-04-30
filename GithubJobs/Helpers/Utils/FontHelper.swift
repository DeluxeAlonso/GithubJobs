import UIKit

/// A comprehensive font management system that supports system and custom fonts,
/// with full accessibility scaling support and semantic naming.
struct FontHelper {

    // MARK: - Font Size

    enum FontSize: CGFloat {
        case extraSmall = 12
        case small = 14
        case medium = 15
        case big = 16
        case large = 18
        case extraLarge = 22
        case huge = 28

        /// Creates a custom size
        static func custom(_ size: CGFloat) -> CGFloat {
            return size
        }
    }

    // MARK: - Font Family

    enum FontFamily {
        case system
        case custom(String)

        var name: String {
            switch self {
            case .system:
                return ""
            case .custom(let name):
                return name
            }
        }
    }

    // MARK: - Font Weight Methods

    static func ultraLight(withSize size: CGFloat, family: FontFamily = .system) -> UIFont {
        return font(with: .ultraLight, size: size, family: family)
    }

    static func thin(withSize size: CGFloat, family: FontFamily = .system) -> UIFont {
        return font(with: .thin, size: size, family: family)
    }

    static func light(withSize size: CGFloat, family: FontFamily = .system) -> UIFont {
        return font(with: .light, size: size, family: family)
    }

    static func regular(withSize size: CGFloat, family: FontFamily = .system) -> UIFont {
        return font(with: .regular, size: size, family: family)
    }

    static func medium(withSize size: CGFloat, family: FontFamily = .system) -> UIFont {
        return font(with: .medium, size: size, family: family)
    }

    static func semiBold(withSize size: CGFloat, family: FontFamily = .system) -> UIFont {
        return font(with: .semibold, size: size, family: family)
    }

    static func bold(withSize size: CGFloat, family: FontFamily = .system) -> UIFont {
        return font(with: .bold, size: size, family: family)
    }

    static func heavy(withSize size: CGFloat, family: FontFamily = .system) -> UIFont {
        return font(with: .heavy, size: size, family: family)
    }

    static func black(withSize size: CGFloat, family: FontFamily = .system) -> UIFont {
        return font(with: .black, size: size, family: family)
    }

    // MARK: - Helper Methods

    private static func font(with weight: UIFont.Weight, size: CGFloat, family: FontFamily) -> UIFont {
        switch family {
        case .system:
            return UIFont.systemFont(ofSize: size, weight: weight)
        case .custom(let name):
            if let font = UIFont(name: "\(name)-\(weightString(for: weight))", size: size) {
                return font
            } else {
                // Fallback to system font if custom font is not available
                print("Warning: Could not load custom font \(name)-\(weightString(for: weight)). Using system font instead.")
                return UIFont.systemFont(ofSize: size, weight: weight)
            }
        }
    }

    private static func weightString(for weight: UIFont.Weight) -> String {
        switch weight {
        case .ultraLight: return "UltraLight"
        case .thin: return "Thin"
        case .light: return "Light"
        case .regular: return "Regular"
        case .medium: return "Medium"
        case .semibold: return "SemiBold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .black: return "Black"
        default: return "Regular"
        }
    }

    // MARK: - Dynamic Fonts

    /// Creates a scalable font that respects the user's accessibility settings
    ///
    /// - Parameters:
    ///   - textStyle: The text style to match
    ///   - font: Optional custom font to scale. If nil, returns the system preferred font.
    ///   - maximumPointSize: Optional maximum size to prevent font from growing too large
    ///   - compatibleWith: Optional trait collection to use for scaling
    /// - Returns: A scaled UIFont that will automatically adjust with the user's settings
    static func dynamic(_ textStyle: UIFont.TextStyle,
                        font: UIFont? = nil,
                        maximumPointSize: CGFloat? = nil,
                        compatibleWith traitCollection: UITraitCollection? = nil) -> UIFont {
        guard let font = font else {
            return .preferredFont(forTextStyle: textStyle)
        }

        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)

        if let maximumSize = maximumPointSize {
            return fontMetrics.scaledFont(for: font, maximumPointSize: maximumSize, compatibleWith: traitCollection)
        } else {
            return fontMetrics.scaledFont(for: font, compatibleWith: traitCollection)
        }
    }

    // MARK: - Font Registration

    /// Registers custom fonts from the app bundle
    /// - Parameter bundles: The bundles containing the font files (default is main bundle)
    /// - Returns: Array of registered font names or error messages
    @discardableResult
    static func registerFonts(from bundles: [Bundle] = [Bundle.main]) -> [String] {
        var results = [String]()

        for bundle in bundles {
            guard let fontURLs = bundle.urls(forResourcesWithExtension: "ttf", subdirectory: nil) else { continue }

            for url in fontURLs {
                guard let fontDataProvider = CGDataProvider(url: url as CFURL) else {
                    results.append("Could not create data provider for font at \(url)")
                    continue
                }

                guard let font = CGFont(fontDataProvider) else {
                    results.append("Could not create font from data provider for \(url)")
                    continue
                }

                var error: Unmanaged<CFError>?
                if !CTFontManagerRegisterGraphicsFont(font, &error) {
                    if let error = error?.takeRetainedValue() {
                        results.append("Error registering font: \(error)")
                    } else {
                        results.append("Unknown error registering font \(url)")
                    }
                } else {
                    if let fontName = font.fullName as String? {
                        results.append("Successfully registered font: \(fontName)")
                    } else {
                        results.append("Successfully registered font at \(url)")
                    }
                }
            }
        }

        return results
    }
}

// MARK: - Semantic Font Extensions

extension FontHelper {

    /// Semantic font definitions for the application
    struct Semantic {
        // Text elements
        static let bodyText = FontHelper.regular(withSize: FontSize.medium.rawValue)
        static let bodyTextBold = FontHelper.semiBold(withSize: FontSize.medium.rawValue)

        // Headers
        static let h1 = FontHelper.bold(withSize: FontSize.huge.rawValue)
        static let h2 = FontHelper.bold(withSize: FontSize.extraLarge.rawValue)
        static let h3 = FontHelper.bold(withSize: FontSize.large.rawValue)
        static let h4 = FontHelper.semiBold(withSize: FontSize.big.rawValue)

        // UI Elements
        static let buttonTitle = FontHelper.medium(withSize: FontSize.medium.rawValue)
        static let caption = FontHelper.regular(withSize: FontSize.small.rawValue)
        static let footnote = FontHelper.light(withSize: FontSize.extraSmall.rawValue)
    }

    /// Default system font configurations
    struct Default {
        // Small fonts
        static let extraSmallLight = FontHelper.light(withSize: FontSize.extraSmall.rawValue)
        static let extraSmallRegular = FontHelper.regular(withSize: FontSize.extraSmall.rawValue)
        static let extraSmallMedium = FontHelper.medium(withSize: FontSize.extraSmall.rawValue)
        static let extraSmallBold = FontHelper.bold(withSize: FontSize.extraSmall.rawValue)

        // Small fonts
        static let smallLight = FontHelper.light(withSize: FontSize.small.rawValue)
        static let smallRegular = FontHelper.regular(withSize: FontSize.small.rawValue)
        static let smallMedium = FontHelper.medium(withSize: FontSize.small.rawValue)
        static let smallBold = FontHelper.bold(withSize: FontSize.small.rawValue)

        // Medium fonts
        static let mediumLight = FontHelper.light(withSize: FontSize.medium.rawValue)
        static let mediumRegular = FontHelper.regular(withSize: FontSize.medium.rawValue)
        static let mediumMedium = FontHelper.medium(withSize: FontSize.medium.rawValue)
        static let mediumBold = FontHelper.bold(withSize: FontSize.medium.rawValue)
        static let mediumSemiBold = FontHelper.semiBold(withSize: FontSize.medium.rawValue)

        // Big fonts
        static let bigLight = FontHelper.light(withSize: FontSize.big.rawValue)
        static let bigRegular = FontHelper.regular(withSize: FontSize.big.rawValue)
        static let bigMedium = FontHelper.medium(withSize: FontSize.big.rawValue)
        static let bigBold = FontHelper.bold(withSize: FontSize.big.rawValue)

        // Large fonts
        static let largeLight = FontHelper.light(withSize: FontSize.large.rawValue)
        static let largeRegular = FontHelper.regular(withSize: FontSize.large.rawValue)
        static let largeMedium = FontHelper.medium(withSize: FontSize.large.rawValue)
        static let largeBold = FontHelper.bold(withSize: FontSize.large.rawValue)

        // Extra Large fonts
        static let extraLargeLight = FontHelper.light(withSize: FontSize.extraLarge.rawValue)
        static let extraLargeRegular = FontHelper.regular(withSize: FontSize.extraLarge.rawValue)
        static let extraLargeBold = FontHelper.bold(withSize: FontSize.extraLarge.rawValue)

        // Huge fonts
        static let hugeLight = FontHelper.light(withSize: FontSize.huge.rawValue)
        static let hugeRegular = FontHelper.regular(withSize: FontSize.huge.rawValue)
        static let hugeBold = FontHelper.bold(withSize: FontSize.huge.rawValue)
    }

    /// Dynamic fonts that adapt to accessibility settings
    struct Dynamic {
        static let title1 = FontHelper.dynamic(.title1, font: Semantic.h1)
        static let title2 = FontHelper.dynamic(.title2, font: Semantic.h2)
        static let title3 = FontHelper.dynamic(.title3, font: Semantic.h3)
        static let headline = FontHelper.dynamic(.headline, font: Semantic.h4)
        static let subheadline = FontHelper.dynamic(.subheadline, font: Default.mediumSemiBold)
        static let body = FontHelper.dynamic(.body, font: Semantic.bodyText)
        static let callout = FontHelper.dynamic(.callout, font: Default.mediumMedium)
        static let footnote = FontHelper.dynamic(.footnote, font: Semantic.footnote)
        static let caption1 = FontHelper.dynamic(.caption1, font: Semantic.caption)
        static let caption2 = FontHelper.dynamic(.caption2, font: Default.extraSmallRegular)

        // With maximum sizes to prevent overly large fonts
        static let limitedTitle1 = FontHelper.dynamic(.title1, font: Semantic.h1, maximumPointSize: 38)
        static let limitedBody = FontHelper.dynamic(.body, font: Semantic.bodyText, maximumPointSize: 22)
    }
}
