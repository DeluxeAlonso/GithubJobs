//
//  ThemeSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 7/07/22.
//

import Combine

final class ThemeSelectionViewModel: ThemeSelectionViewModelProtocol {

    private let themeManager: ThemeManagerProtocol
    private let interactor: ThemeSelectionInteractorProtocol

    private(set) var didSelectTheme = PassthroughSubject<Void, Never>()

    // MARK: - Initializers

    init(interactor: ThemeSelectionInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - ThemeSelectionViewModelProtocol

    var themes: [ThemeSelectionItemModel] = []

    func loadThemes() {
        Task {
            let selectedTheme = await themeManager.theme
            self.themes = Theme.allCases.map { theme in
                let isSelected = selectedTheme == theme
                return ThemeSelectionItemModel(theme, isSelected: isSelected)
            }
            self.themes = await t
            didSelectTheme.send()
        }
    }

    func screenTitle() -> String? {
        LocalizedStrings.themeSelectionTitle()
    }

    func headerTitle(for section: Int) -> String? {
        LocalizedStrings.themeSelectionHeaderTitle()
    }

    func selectTheme(at index: Int) {
        Task {
            let selectedTheme = themes[index]
            // TODO: Evaluate making this return the list of ThemeSelectionItemModel.
            await themeManager.updateTheme(selectedTheme.theme)
            // TODO: Implement and interactor and revisit this.
            loadThemes()
            didSelectTheme.send()
        }
    }

}
