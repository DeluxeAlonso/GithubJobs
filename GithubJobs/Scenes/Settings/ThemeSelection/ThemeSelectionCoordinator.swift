//
//  ThemeSelectionCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import UIKit

final class ThemeSelectionCoordinator: NSObject, Coordinator, ThemeSelectionCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var presentingViewController: UIViewController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let themeManager = ThemeManager.shared
        let viewModel = ThemeSelectionViewModel(themeManager: themeManager)
        let viewController = ThemeSelectionViewController(themeManager: themeManager,
                                                          viewModel: viewModel,
                                                          coordinator: self)

        navigationController.pushViewController(viewController, animated: false)
        navigationController.modalPresentationStyle = .fullScreen

        presentingViewController.present(navigationController, animated: true, completion: nil)
    }

    func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
