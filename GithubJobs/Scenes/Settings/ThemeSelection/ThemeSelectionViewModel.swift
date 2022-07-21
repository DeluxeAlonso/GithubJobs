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
            let isSelected = themeManager.interfaceStyle.value == theme.asUserInterfaceStyle()
            return ThemeModel(theme, isSelected: isSelected)
        }
    }

    func headerTitle(for section: Int) -> String? {
        return "Theme"
    }

    func selectTheme(at index: Int) {
        let selectedTheme = themes[index]
        themeManager.updateInterfaceStyle(selectedTheme.theme.asUserInterfaceStyle())
        didSelectTheme.send()
    }

}
