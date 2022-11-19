//
//  SettingsCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import UIKit

final class SettingsCoordinator: BaseCoordinator, SettingsCoordinatorProtocol {

    var presentingViewController: UIViewController?

    override func start() {
        let themeManager = ThemeManager.shared
        let viewModel = SettingsViewModel(themeManager: themeManager)
        let viewController = SettingsViewController(themeManager: themeManager,
                                                    viewModel: viewModel,
                                                    coordinator: self)

        navigationController.pushViewController(viewController, animated: false)
        navigationController.modalPresentationStyle = .fullScreen

        presentingViewController?.present(navigationController, animated: true, completion: {
            if self.navigationController.delegate == nil {
                self.navigationController.delegate = self
            }
        })
    }

    // MARK: - SettingsCoordinatorProtocol

    func showThemeSelection() {
        let coordinator = ThemeSelectionCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
