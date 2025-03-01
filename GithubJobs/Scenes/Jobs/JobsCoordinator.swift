//
//  JobsCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class JobsCoordinator: BaseCoordinatorDEPRECATED, JobsCoordinatorProtocol {

    override func start() {
        let interactor = JobsInteractor(jobsClient: JobsClient())
        let viewModel = JobsViewModel(interactor: interactor)

        let viewController = JobsViewController(themeManager: ThemeManager.shared,
                                                viewModel: viewModel,
                                                coordinator: self)

        if navigationController.delegate == nil {
            navigationController.delegate = self
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    // MARK: - JobsCoordinatorProtocol

    func showJobDetail(_ job: Job) {
        let coordinator = JobDetailCoordinator(navigationController: navigationController,
                                               detailNavigationController: UINavigationController(),
                                               job: job)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
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
