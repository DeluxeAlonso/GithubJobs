//
//  JobDetailCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class JobDetailCoordinator: BaseCoordinator, JobDetailCoordinatorProtocol {

    private let job: Job

    init(navigationController: UINavigationController,
         detailNavigationController: UINavigationController? = nil,
         job: Job) {
        self.job = job
        super.init(navigationController: navigationController)
        self.detailNavigationController = detailNavigationController
    }

    override func build() -> UIViewController {
        let interactor = JobsInteractor(jobsClient: JobsClient())
        let viewModel = JobDetailViewModel(job, interactor: interactor)
        return JobDetailViewController(themeManager: ThemeManager.shared,
                                       viewModel: viewModel,
                                       coordinator: self)
    }

//    override func start() {
//        let interactor = JobsInteractor(jobsClient: JobsClient())
//        let viewModel = JobDetailViewModel(job, interactor: interactor)
//        let viewController = JobDetailViewController(themeManager: ThemeManager.shared,
//                                                     viewModel: viewModel,
//                                                     coordinator: self)
//
//        if let detailNavigationController = detailNavigationController {
//            detailNavigationController.pushViewController(viewController, animated: false)
//            navigationController.showDetailViewController(detailNavigationController, sender: nil)
//        } else {
//            detailNavigationController = navigationController
//            navigationController.pushViewController(viewController, animated: true)
//        }
//        if navigationController.delegate == nil {
//            navigationController.delegate = self
//        }
//    }

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
        coordinator.start(coordinatorMode: .push)
    }

}
