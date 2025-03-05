//
//  CoordinatorModePresentConfiguration.swift
//  GithubJobs
//
//  Created by Alonso on 20/02/25.
//

import UIKit

/**
 * Configuration structure for modal presentations in coordinators.
 *
 * This structure provides a way to customize modal presentations
 * with specific presentation styles and transition animations.
 */
struct CoordinatorModePresentConfiguration {

    /// The style for modal presentation (fullscreen, formSheet, popover, etc.).
    let modalPresentationStyle: UIModalPresentationStyle

    /// Optional delegate for custom transition animations.
    let transitioningDelegate: UIViewControllerTransitioningDelegate?
}
