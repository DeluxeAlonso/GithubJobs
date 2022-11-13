//
//  JobDetailCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class JobDetailCoordinator: NSObject, JobDetailCoordinatorProtocol, Coordinator, UINavigationControllerDelegate {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var detailNavigationController: UINavigationController?

    var job: Job!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
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

    func showJobDetail(_ job: Job) {
        let navController = detailNavigationController != nil ? detailNavigationController! : navigationController
        let coordinator = JobDetailCoordinator(navigationController: navController)
        coordinator.job = job

        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    // MARK: - UINavigationControllerDelegate

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
