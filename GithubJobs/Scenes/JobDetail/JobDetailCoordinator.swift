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
    var detailNavigationController: UINavigationController?

    var job: Job!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = JobDetailViewModel(job, jobClient: JobClient())
        let viewController = JobDetailViewController(viewModel: viewModel, coordinator: self)

        if let detailNavigationController = detailNavigationController {
            detailNavigationController.pushViewController(viewController, animated: false)
            navigationController.showDetailViewController(detailNavigationController, sender: nil)
        } else {
            detailNavigationController = navigationController
            navigationController.pushViewController(viewController, animated: true)
        }
    }

    func showJobDetail(_ job: Job) {
        let navController = detailNavigationController != nil ? detailNavigationController! : navigationController
        let coordinator = JobDetailCoordinator(navigationController: navController)
        coordinator.job = job

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

}
