//
//  ThemeSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 7/07/22.
//

import Combine

final class ThemeSelectionViewModel: ThemeSelectionViewModelProtocol {

    private let interactor: ThemeSelectionInteractorProtocol

    // MARK: - Initializers

    init(interactor: ThemeSelectionInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - ThemeSelectionViewModelProtocol

    private(set) var themes = CurrentValueSubject<[ThemeSelectionItemModel], Never>([])

    func loadThemes() {
        Task {
            self.themes.value = try await interactor.getAllThemes()
        }
    }

    func screenTitle() -> String? {
        LocalizedStrings.themeSelectionTitle()
    }

    func headerTitle(for section: Int) -> String? {
        LocalizedStrings.themeSelectionHeaderTitle()
    }

    func isSelected(at index: Int) -> Bool {
        themes.value[index].isSelected
    }

    func selectTheme(at index: Int) {
        Task {
            let selectedTheme = themes.value[index]
            self.themes.value = try await interactor.updateTheme(selectedTheme.theme)
        }
    }

}
