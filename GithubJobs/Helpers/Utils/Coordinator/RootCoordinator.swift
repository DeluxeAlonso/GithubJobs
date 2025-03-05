//
//  RootCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 19/02/25.
//

/**
 * Defines a coordinator that serves as the root of a coordinator hierarchy.
 *
 * Root coordinators typically represent the main flows or tabs in an application,
 * and are directly managed by the application coordinator or app delegate.
 */
protocol RootCoordinator: Coordinator {

    /**
     * A unique identifier for this root coordinator.
     *
     * This can be used to distinguish between different root flows,
     * especially in applications with multiple tabs or main sections.
     */
    var rootIdentifier: String { get }
}
