//
//  ThemeSelectionProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

protocol ThemeSelectionViewModelProtocol {

    func title(for theme: Theme) -> String?

}

protocol ThemeSelectionCoordinatorProtocol: AnyObject {}
