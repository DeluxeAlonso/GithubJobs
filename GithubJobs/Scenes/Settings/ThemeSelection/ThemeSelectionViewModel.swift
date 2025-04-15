//
//  ThemeSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 7/07/22.
//

import Combine

final class ThemeSelectionViewModel: ThemeSelectionViewModelProtocol {

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
            self.themes = try await interactor.getAllThemes()
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
            self.themes = try await interactor.updateTheme(selectedTheme.theme)
            didSelectTheme.send()
        }
    }

}
