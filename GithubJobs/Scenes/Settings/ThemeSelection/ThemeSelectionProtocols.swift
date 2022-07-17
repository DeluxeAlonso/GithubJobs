//
//  ThemeSelectionProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

protocol ThemeSelectionViewModelProtocol {

    var themes: [ThemeSelectionViewModel.ThemeModel] { get }

    func headerTitle(for section: Int) -> String?
    func selectTheme(at index: Int)

}

protocol ThemeSelectionCoordinatorProtocol: AnyObject {
    func dismiss()
}
