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

    var themes: [Theme] {
        return Theme.allCases
    }

    func title(for theme: Theme) -> String? {
        switch theme {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }

    func headerTitle(for section: Int) -> String? {
        return "Theme"
    }

}
