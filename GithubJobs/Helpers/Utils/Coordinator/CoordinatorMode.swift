//
//  CoordinatorMode.swift
//  GithubJobs
//
//  Created by Alonso on 18/02/25.
//

import UIKit

/**
 * Defines the presentation modes available for coordinators.
 *
 * This enum allows coordinators to present their view controllers in different ways,
 * providing flexibility in navigation patterns across the application.
 */
enum CoordinatorMode {

    /// Pushes the view controller onto the navigation stack.
    case push

    /**
     * Presents the view controller modally.
     *
     * - Parameters:
     *   - presentingViewController: The view controller that will present the new controller.
     *   - configuration: Optional configuration for the modal presentation (style, transitions).
     */
    case present(presentingViewController: UIViewController, configuration: CoordinatorModePresentConfiguration?)

    /**
     * Embeds the view controller as a child of another view controller.
     *
     * - Parameters:
     *   - parentViewController: The parent view controller that will contain the new controller.
     *   - containerView: Optional specific container view within the parent where the child will be added.
     */
    case embed(parentViewController: UIViewController, containerView: UIView?)
}
