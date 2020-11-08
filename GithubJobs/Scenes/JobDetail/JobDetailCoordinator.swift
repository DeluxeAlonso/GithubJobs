//
//  JobDetailCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class JobDetailCoordinator: NSObject, JobDetailCoordinatorProtocol, Coordinator {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var job: Job!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = JobDetailViewModel(jobClient: JobClient(), job: job)
        let viewController = JobDetailViewController(viewModel: viewModel, coordinator: self)

        navigationController.pushViewController(viewController, animated: true)
    }

    func showJobDetail(_ job: Job) {
        let coordinator = JobDetailCoordinator(navigationController: navigationController)
        coordinator.job = job

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

}
