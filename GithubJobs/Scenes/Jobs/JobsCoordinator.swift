//
//  JobsCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class JobsCoordinator: NSObject, JobsCoordinatorProtocol, Coordinator, UINavigationControllerDelegate {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let interactor = JobsInteractor(jobClient: JobClient())
        let viewModel = JobsViewModel(interactor: interactor)

        let viewController = JobsViewController(themeManager: ThemeManager.shared,
                                                viewModel: viewModel,
                                                coordinator: self)

        if navigationController.delegate == nil {
            navigationController.delegate = self
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func showJobDetail(_ job: Job) {
        let coordinator = JobDetailCoordinator(navigationController: navigationController)
        coordinator.job = job
        coordinator.detailNavigationController = UINavigationController()

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    func showSettings() {
        let coordinator = SettingsCoordinator(navigationController: UINavigationController())
        coordinator.presentingViewController = navigationController.topViewController
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        finishChildIfNeeded()
    }

}
