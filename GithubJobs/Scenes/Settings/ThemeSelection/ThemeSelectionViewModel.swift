//
//  ThemeSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 7/07/22.
//

import Combine

final class ThemeSelectionViewModel: ThemeSelectionViewModelProtocol {

    private let themeManager: ThemeManagerProtocol

    var didSelectTheme = PassthroughSubject<Void, Never>()

    // MARK: - Initializers

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager
    }

    // MARK: - ThemeSelectionViewModelProtocol

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

    func selectTheme(at index: Int) {
        let selectedTheme = Theme.allCases[index]
        themeManager.updateInterfaceStyle(selectedTheme.asUserInterfaceStyle())
        didSelectTheme.send()
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
