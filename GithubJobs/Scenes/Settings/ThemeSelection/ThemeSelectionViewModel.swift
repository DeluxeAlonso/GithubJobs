//
//  ThemeSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 7/07/22.
//

import Combine

final class ThemeSelectionViewModel: ThemeSelectionViewModelProtocol {

    private let themeManager: ThemeManagerProtocol

    private(set) var didSelectTheme = PassthroughSubject<Void, Never>()

    // MARK: - Initializers

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager
    }

    // MARK: - ThemeSelectionViewModelProtocol

    var themes: [ThemeSelectionItemModel] {
        Theme.allCases.map { theme in
            let isSelected = themeManager.interfaceStyle.value == theme.asUserInterfaceStyle()
            return ThemeSelectionItemModel(theme, isSelected: isSelected)
        }
    }

    func screenTitle() -> String? {
        LocalizedStrings.themeSelectionTitle()
    }

    func headerTitle(for section: Int) -> String? {
        LocalizedStrings.themeSelectionHeaderTitle()
    }

    func selectTheme(at index: Int) {
        let selectedTheme = themes[index]
        themeManager.updateInterfaceStyle(selectedTheme.theme.asUserInterfaceStyle())
        didSelectTheme.send()
    }

}
