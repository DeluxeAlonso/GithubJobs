//
//  SettingsCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Coordinator
import UIKit

enum SettingsNavigation {
    case theme
    case faqs
    case featureFlags
}

final class SettingsCoordinator: BaseCoordinator, SettingsCoordinatorProtocol {

    override func build() -> UIViewController {
        let themeManager = ThemeManager.shared
        let featureFlagsManager = FeatureFlagsManager.shared
        let interactor = SettingsInteractor(themeManager: themeManager, featureFlagsManager: featureFlagsManager)
        let viewModel = SettingsViewModel(interactor: interactor)
        return SettingsViewController(themeManager: themeManager,
                                                    viewModel: viewModel,
                                                    coordinator: self)
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
        coordinator.start(coordinatorMode: .push)
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

}
