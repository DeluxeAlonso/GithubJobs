//
//  ThemeManagerProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 24/04/21.
//

import Combine

/// Protocol for managing themes within the application.
/// Provides access to the current theme and a way to observe theme changes.
protocol ThemeManagerProtocol: Actor {

    /// The current theme applied to the application.
    var theme: Theme { get }

    /// A publisher that emits the current theme and any future theme changes.
    /// Use this to observe theme changes across the application.
    var themeSubject: CurrentValueSubject<Theme, Never> { get }

    /// Updates the current application theme.
    /// - Parameter theme: The new theme to apply.
    func updateTheme(_ theme: Theme)
}
