//
//  SettingsCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import UIKit

enum SettingsNavigation {
    case theme
    case faqs
    case featureFlags
}

final class SettingsCoordinator: BaseCoordinator, SettingsCoordinatorProtocol {

    var presentingViewController: UIViewController?

    override func start() {
        let themeManager = ThemeManager.shared
        let featureFlagsManager = FeatureFlagsManager.shared
        let interactor = SettingsInteractor(themeManager: themeManager, featureFlagsManager: featureFlagsManager)
        let viewModel = SettingsViewModel(interactor: interactor)
        let viewController = SettingsViewController(themeManager: themeManager,
                                                    viewModel: viewModel,
                                                    coordinator: self)

        navigationController.pushViewController(viewController, animated: false)
        navigationController.modalPresentationStyle = .automatic

        presentingViewController?.present(navigationController, animated: true, completion: {
            if self.navigationController.delegate == nil {
                self.navigationController.delegate = self
            }
        })
    }

    // MARK: - SettingsCoordinatorProtocol

    func startNavigation(for navigation: SettingsNavigation) {
        switch navigation {
        case .theme:
            showThemeSelection()
        case .faqs:
            showFAQs()
        case .featureFlags:
            showFeatureFlags()
        }
    }

    private func showThemeSelection() {
        let coordinator = ThemeSelectionCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    private func showFAQs() {
        let coordinator = FAQsCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
    }

    private func showFeatureFlags() {
        let coordinator = FeatureFlagsCoordinator(navigationController: navigationController)

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
    }

    func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
