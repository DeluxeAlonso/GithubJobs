//
//  JobDetailCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class JobDetailCoordinator: BaseCoordinator, JobDetailCoordinatorProtocol {

    var detailNavigationController: UINavigationController?
    private let job: Job

    init(navigationController: UINavigationController, job: Job) {
        self.job = job
        super.init(navigationController: navigationController)
    }

    override func start() {
        let interactor = JobsInteractor(jobClient: JobClient())
        let viewModel = JobDetailViewModel(job, interactor: interactor)
        let viewController = JobDetailViewController(themeManager: ThemeManager.shared,
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

    // MARK: - JobDetailCoordinatorProtocol

    func showJobDetail(_ job: Job) {
        let navController: UINavigationController
        if let detailNavigationController {
            navController = detailNavigationController
        } else {
            navController = navigationController
        }
        let coordinator = JobDetailCoordinator(navigationController: navController, job: job)
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

}
