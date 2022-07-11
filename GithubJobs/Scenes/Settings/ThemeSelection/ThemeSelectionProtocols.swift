//
//  ThemeSelectionProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

protocol ThemeSelectionViewModelProtocol {

    var themes: [Theme] { get }

    func title(for theme: Theme) -> String?
    func headerTitle(for section: Int) -> String?

}

protocol ThemeSelectionCoordinatorProtocol: AnyObject {}
