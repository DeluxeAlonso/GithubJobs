//
//  Coordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

protocol Coordinator: class {

    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    var navigationController: UINavigationController { get set }

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
