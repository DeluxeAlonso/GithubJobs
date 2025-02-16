//
//  Coordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

protocol Coordinator_DEPRECATED: AnyObject {

    var childCoordinators: [Coordinator_DEPRECATED] { get set }
    var parentCoordinator: Coordinator_DEPRECATED? { get set }
    var navigationController: UINavigationController { get }

    func start()
    func childDidFinish(_ child: Coordinator_DEPRECATED)

}

extension Coordinator_DEPRECATED {

    /// If we don't have a parent coordinator set up, the parent coordinator is the coordinator itself.
    var unwrappedParentCoordinator: Coordinator_DEPRECATED {
        parentCoordinator ?? self
    }

    func childDidFinish(_ child: Coordinator_DEPRECATED) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }

    func childDidFinish() {
        childCoordinators.removeLast()
    }

}
