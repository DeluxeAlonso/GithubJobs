//
//  JobDetailCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Coordinator
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

    // MARK: - JobDetailCoordinatorProtocol

    func showJobDetail(_ job: Job) {
        let navController: UINavigationController
        if let detailNavigationController {
            navController = detailNavigationController
        } else {
            navController = navigationController
        }
        let coordinator = JobDetailCoordinator(navigationController: navController, job: job)
        start(coordinator, coordinatorMode: .push)
    }

}
