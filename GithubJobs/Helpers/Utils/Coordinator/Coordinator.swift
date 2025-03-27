//
//  Coordinator.swift
//  GithubJobs
//
//  Created by Alonso on 17/02/25.
//

import UIKit

/**
 * Coordinator protocol defines the core functionality for navigation coordination.
 *
 * The Coordinator pattern helps separate navigation logic from view controllers,
 * creating a cleaner architecture where view controllers focus solely on view-related concerns.
 * Each coordinator is responsible for a specific flow within the application.
 */
@MainActor
protocol Coordinator: AnyObject {

    /// Array to store and maintain references to child coordinators.
    var childCoordinators: [Coordinator] { get set }

    /// Reference to the parent coordinator in the hierarchy.
    var parentCoordinator: Coordinator? { get set }

    /// The navigation controller used by this coordinator to present view controllers.
    var navigationController: UINavigationController { get set }

    /// Indicates whether the coordinator should be automatically removed when its view controllers are dismissed.
    var shouldBeAutomaticallyFinished: Bool { get }

    /**
     * Starts the coordinator's flow with default parameters.
     * This is typically implemented by concrete coordinator subclasses to initialize their flow.
     */
    func start()

    /**
     * Starts the coordinator's flow with a specific presentation mode.
     *
     * - Parameter coordinatorMode: Defines how the coordinator's view controller will be presented
     *   (push, present modally, or embed as a child view controller).
     */
    func start(coordinatorMode: CoordinatorMode)

    /**
     * Removes the last child coordinator from the hierarchy.
     * Typically called when a flow completes and its coordinator is no longer needed.
     */
    func childDidFinish()

    /**
     * Removes a specific child coordinator from the hierarchy.
     *
     * - Parameter child: The child coordinator to be removed.
     */
    func childDidFinish(_ child: Coordinator)
}

extension Coordinator {

    /**
     * Returns the parent coordinator or self if no parent is defined.
     * This ensures that coordinator methods always have a valid target,
     * even when a coordinator doesn't have a parent.
     */
    var unwrappedParentCoordinator: Coordinator {
        parentCoordinator ?? self
    }

    /**
     * Default implementation to remove a specific child coordinator.
     *
     * - Parameter child: The child coordinator to be removed.
     */
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }

    /**
     * Default implementation to clean up child coordinators.
     * This method:
     * 1. First removes all child coordinators marked with shouldBeAutomaticallyFinished = true
     * 2. Then removes the last child coordinator if any remain
     */
    func childDidFinish() {
        childCoordinators.removeLast(while: \.shouldBeAutomaticallyFinished)
        if !childCoordinators.isEmpty {
            childCoordinators.removeLast()
        }
    }
}
