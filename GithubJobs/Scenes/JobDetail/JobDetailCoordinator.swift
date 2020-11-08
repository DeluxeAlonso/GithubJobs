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
        var viewModel = JobDetailViewModel(jobClient: JobClient())
        viewModel.job = job

        let viewController = JobDetailViewController(viewModel: viewModel, coordinator: self)

        navigationController.pushViewController(viewController, animated: true)
    }

}
