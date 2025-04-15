//
//  ThemeSelectionInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 13/04/25.
//

final class ThemeSelectionInteractor: ThemeSelectionInteractorProtocol {

    private let themeManager: ThemeManagerProtocol

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager
    }

    func getAllThemes() async throws -> [ThemeSelectionItemModel] {
        let selectedTheme = await themeManager.theme
        return Theme.allCases.map { theme in
            let isSelected = selectedTheme == theme
            return ThemeSelectionItemModel(theme, isSelected: isSelected)
        }
    }

    @discardableResult
    func updateTheme(_ theme: Theme) async throws -> [ThemeSelectionItemModel] {
        await themeManager.updateTheme(theme)
        return try await getAllThemes()
    }

}
