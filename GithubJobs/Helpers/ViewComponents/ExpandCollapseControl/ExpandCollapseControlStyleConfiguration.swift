//
//  ExpandCollapseControlStyleConfiguration.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import Foundation

/// Configuration options for customizing the appearance and behavior of expandable/collapsible controls.
///
/// Use this struct to configure various aspects of expand/collapse controls, including
/// icon appearance, sizing, and spacing between elements.
struct ExpandCollapseControlStyleConfiguration {

    /// The name of the icon to display when the control is in expanded state.
    let expandedIconName: String

    /// The name of the icon to display when the control is in collapsed state.
    let collapsedIconName: String

    /// The size dimensions for both expanded and collapsed icons.
    let iconSize: CGSize

    /// The padding between the icon and the content that follows it.
    let iconTrailingPadding: CGFloat

    /// Vertical spacing between the collapsed and expanded content.
    let verticalSpacing: CGFloat

    /// Horizontal spacing between elements in the control.
    let horizontalSpacing: CGFloat
}
