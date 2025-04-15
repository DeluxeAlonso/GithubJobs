//
//  ThemeSelectionCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import UIKit

final class ThemeSelectionCoordinator: BaseCoordinator, ThemeSelectionCoordinatorProtocol {

    override func build() -> UIViewController {
        let themeManager = ThemeManager.shared
        let interactor = ThemeSelectionInteractor(themeManager: themeManager)
        let viewModel = ThemeSelectionViewModel(interactor: interactor)
        return ThemeSelectionViewController(themeManager: themeManager,
                                            viewModel: viewModel,
                                            coordinator: self)

    }
    
}
