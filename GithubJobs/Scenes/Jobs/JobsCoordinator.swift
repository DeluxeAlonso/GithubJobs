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
        let viewModel = JobsViewModel(jobClient: JobClient())

        let viewController = JobsViewController(viewModel: viewModel, coordinator: self)

        navigationController.delegate = self
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

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        unwrappedParentCoordinator.childDidFinish()
    }

}
