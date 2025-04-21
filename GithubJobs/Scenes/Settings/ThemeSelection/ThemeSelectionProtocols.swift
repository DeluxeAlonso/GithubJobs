//
//  ThemeSelectionProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import Combine

@MainActor
protocol ThemeSelectionViewModelProtocol {

    var themes: CurrentValueSubject<[ThemeSelectionItemModel], Never> { get }

    func screenTitle() -> String?
    func headerTitle(for section: Int) -> String?

    func loadThemes()
    func isSelected(at index: Int) -> Bool
    func selectTheme(at index: Int)

}

@MainActor
protocol ThemeSelectionCoordinatorProtocol: AnyObject {

    func dismiss()

}

protocol ThemeSelectionInteractorProtocol: Sendable {

    func getAllThemes() async throws -> [ThemeSelectionItemModel]

    @discardableResult
    func updateTheme(_ theme: Theme) async throws -> [ThemeSelectionItemModel]

}
