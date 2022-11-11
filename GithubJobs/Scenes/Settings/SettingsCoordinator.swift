//
//  SettingsCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import UIKit

final class SettingsCoordinator: NSObject, Coordinator, SettingsCoordinatorProtocol, UINavigationControllerDelegate {

    let navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var presentingViewController: UIViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let themeManager = ThemeManager.shared
        let viewModel = SettingsViewModel(themeManager: themeManager)
        let viewController = SettingsViewController(themeManager: themeManager,
                                                    viewModel: viewModel,
                                                    coordinator: self)

        navigationController.pushViewController(viewController, animated: false)
        navigationController.modalPresentationStyle = .fullScreen

        presentingViewController?.present(navigationController, animated: true, completion: {
            self.navigationController.delegate = self
        })
    }

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

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        unwrappedParentCoordinator.childDidFinish()
    }

}
