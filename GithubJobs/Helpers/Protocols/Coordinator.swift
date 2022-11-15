//
//  Coordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

protocol Coordinator: AnyObject {

    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    var navigationController: UINavigationController { get }

    func start()
    func childDidFinish(_ child: Coordinator)

}

extension Coordinator {

    /// If we don't have a parent coordinator set up, the parent coordinator is the coordinator itself.
    var unwrappedParentCoordinator: Coordinator {
        return parentCoordinator ?? self
    }

    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }

    func childDidFinish() {
        childCoordinators.removeLast()
    }

}

extension Coordinator where Self: UINavigationControllerDelegate {

    func finishChildIfNeeded() {
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
