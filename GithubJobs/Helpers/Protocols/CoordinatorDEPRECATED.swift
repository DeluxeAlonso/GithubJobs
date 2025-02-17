//
//  Coordinator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

protocol CoordinatorDEPRECATED: AnyObject {

    var childCoordinators: [CoordinatorDEPRECATED] { get set }
    var parentCoordinator: CoordinatorDEPRECATED? { get set }
    var navigationController: UINavigationController { get }

    func start()
    func childDidFinish(_ child: CoordinatorDEPRECATED)

}

extension CoordinatorDEPRECATED {

    /// If we don't have a parent coordinator set up, the parent coordinator is the coordinator itself.
    var unwrappedParentCoordinator: CoordinatorDEPRECATED {
        parentCoordinator ?? self
    }

    func childDidFinish(_ child: CoordinatorDEPRECATED) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }

    func childDidFinish() {
        childCoordinators.removeLast()
    }

}
