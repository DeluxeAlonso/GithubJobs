//
//  ThemeSelectionCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import UIKit

final class ThemeSelectionCoordinator: BaseCoordinator, ThemeSelectionCoordinatorProtocol {

    var presentingViewController: UIViewController?
    var detailNavigationController: UINavigationController?

    override func start() {
        let themeManager = ThemeManager.shared
        let viewModel = ThemeSelectionViewModel(themeManager: themeManager)
        let viewController = ThemeSelectionViewController(themeManager: themeManager,
                                                          viewModel: viewModel,
                                                          coordinator: self)

        if let detailNavigationController = detailNavigationController {
            detailNavigationController.pushViewController(viewController, animated: false)
            navigationController.showDetailViewController(detailNavigationController, sender: nil)
        } else {
            detailNavigationController = navigationController
            navigationController.pushViewController(viewController, animated: true)
        }
        if navigationController.delegate == nil {
            navigationController.delegate = self
        }
    }

    // MARK: - ThemeSelectionCoordinatorProtocol

    func startModally() {
        let themeManager = ThemeManager.shared
        let viewModel = ThemeSelectionViewModel(themeManager: themeManager)
        let viewController = ThemeSelectionViewController(themeManager: themeManager,
                                                          viewModel: viewModel,
                                                          coordinator: self)

        navigationController.pushViewController(viewController, animated: false)
        navigationController.modalPresentationStyle = .fullScreen

        presentingViewController?.present(navigationController, animated: true, completion: nil)
    }

    func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
