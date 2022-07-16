//
//  ThemeSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 7/07/22.
//

final class ThemeSelectionViewModel: ThemeSelectionViewModelProtocol {

    private let themeManager: ThemeManagerProtocol

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager
    }

    var themes: [ThemeModel] {
        return Theme.allCases.map { theme in
            let title = self.title(for: theme)
            let isSelected = themeManager.interfaceStyle.value == theme.asUserInterfaceStyle()
            return ThemeModel(title, isSelected: isSelected)
        }
    }

    func title(for theme: Theme) -> String {
        switch theme {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }

    func headerTitle(for section: Int) -> String? {
        return "Theme"
    }

    // MARK: - Theme model

    struct ThemeModel: Equatable, Hashable {
        let title: String
        let isSelected: Bool

        init(_ title: String, isSelected: Bool) {
            self.title = title
            self.isSelected = isSelected
        }
    }

}
