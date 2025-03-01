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
        let viewModel = ThemeSelectionViewModel(themeManager: themeManager)
        return ThemeSelectionViewController(themeManager: themeManager,
                                            viewModel: viewModel,
                                            coordinator: self)

    }

    // MARK: - ThemeSelectionCoordinatorProtocol

//    func startModally() {
//        let themeManager = ThemeManager.shared
//        let viewModel = ThemeSelectionViewModel(themeManager: themeManager)
//        let viewController = ThemeSelectionViewController(themeManager: themeManager,
//                                                          viewModel: viewModel,
//                                                          coordinator: self)
//
//        navigationController.pushViewController(viewController, animated: false)
//        navigationController.modalPresentationStyle = .fullScreen
//
//        presentingViewController?.present(navigationController, animated: true, completion: nil)
//    }

}
