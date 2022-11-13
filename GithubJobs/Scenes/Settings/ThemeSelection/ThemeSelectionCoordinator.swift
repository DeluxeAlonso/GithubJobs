//
//  ThemeSelectionCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import UIKit

final class ThemeSelectionCoordinator: NSObject, Coordinator, ThemeSelectionCoordinatorProtocol, UINavigationControllerDelegate {

    let navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var presentingViewController: UIViewController?
    var detailNavigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
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

    // MARK: - UINavigationControllerDelegate

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
