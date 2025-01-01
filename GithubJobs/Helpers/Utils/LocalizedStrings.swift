//
// Auto-generated code. Do not modify this file manually.
//

import Foundation

protocol Localizable {
    var tableName: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var tableName: String {
        "Localizable"
    }

    func callAsFunction() -> String {
        rawValue.localized(tableName: tableName)
    }
}

private extension String {
    func localized(bundle: Bundle = .main,
                   tableName: String,
                   comment: String = "") -> String {
        NSLocalizedString(self, tableName: tableName, value: self, comment: comment)
    }
}

enum LocalizedStrings: String, Localizable {
    case jobsTitle
	case emptyJobsTitle
	case relatedJobsTitle
	case emptyRelatedJobsTitle
	case themeSelectionTitle
	case themeSelectionHeaderTitle
	case themeSelectionBarButtonItemTitle
	case settingsTitle
	case settingsThemeSelectionRowTitle
	case settingsFeatureFlagRowTitle
	case settingsFAQsRowTitle
	case refreshControlTitle
	case errorTitle
}
