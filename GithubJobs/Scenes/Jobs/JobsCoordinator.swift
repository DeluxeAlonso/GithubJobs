//
//  JobsCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Coordinator
import UIKit

final class JobsCoordinator: BaseCoordinator, JobsCoordinatorProtocol {

    override func build() -> UIViewController {
        let interactor = JobsInteractor(jobsClient: JobsClient())
        let viewModel = JobsViewModel(interactor: interactor)

        return JobsViewController(themeManager: ThemeManager.shared,
                                  viewModel: viewModel,
                                  coordinator: self)
    }

    // MARK: - JobsCoordinatorProtocol

    func showJobDetail(_ job: Job) {
        let coordinator = JobDetailCoordinator(navigationController: navigationController,
                                               detailNavigationController: UINavigationController(),
                                               job: job)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .push)
    }

    func showSettings() {
        guard let presentingViewController = navigationController.topViewController else { return }

        let coordinator = SettingsCoordinator(navigationController: UINavigationController())
        coordinator.presentingViewController = navigationController.topViewController
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start(coordinatorMode: .present(presentingViewController: presentingViewController, configuration: nil))
    }
    
}
