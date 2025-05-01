//
//  Animator.swift
//  GithubJobs
//
//  Created by Alonso on 20/10/22.
//

import UIKit

/// An actor-bound utility class that provides fade animation effects for UIKit views and cells.
/// This class contains static methods to apply consistent fade-in animations across different UI components.
///
/// Usage:
/// ```
/// // Fade in a UIView
/// Animator.fade(view: myView)
///
/// // Fade in a UITableViewCell
/// Animator.fade(tableViewCell: cell)
/// ```
@MainActor
final class Animator {

    /// Applies a fade-in animation to the specified view.
    ///
    /// This method animates the opacity of the provided view from 0.1 to 1.0 over a duration of 0.5 seconds.
    /// The animation allows user interaction during its execution.
    ///
    /// - Parameters:
    ///   - view: The `UIView` to animate.
    ///   - completion: An optional closure to be executed when the animation completes. The closure takes a Boolean
    ///     parameter indicating whether the animation finished successfully.
    static func fade(view: UIView, completion: ((Bool) -> Void)? = nil) {
        view.layer.opacity = 0.1
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: {
            view.layer.opacity = 1
        }, completion: completion)
    }

    /// Applies a fade-in animation to a table view cell's content view.
    ///
    /// This is a convenience method that calls `fade(view:)` with the cell's content view.
    ///
    /// - Parameter tableViewCell: The `UITableViewCell` to animate.
    static func fade(tableViewCell: UITableViewCell) {
        fade(view: tableViewCell.contentView)
    }

    /// Applies a fade-in animation to a collection view cell's content view.
    ///
    /// This is a convenience method that calls `fade(view:)` with the cell's content view.
    ///
    /// - Parameter collectionViewCell: The `UICollectionViewCell` to animate.
    static func fade(collectionViewCell: UICollectionViewCell) {
        fade(view: collectionViewCell.contentView)
    }

}
