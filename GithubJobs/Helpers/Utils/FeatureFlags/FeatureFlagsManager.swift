//
//  ColorManager.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

/// Protocol defining the interface for feature flag management
/// This actor-based protocol ensures thread-safe access to feature flags
protocol FeatureFlagsManagerProtocol: Actor {
    /// Retrieves all available feature flags
    /// - Returns: An array of feature flag objects conforming to `FeatureFlagProtocol`
    func getAllFlags() -> [FeatureFlagProtocol]

    /// Updates the value of a specific feature flag
    /// - Parameters:
    ///   - identifier: The unique string identifier for the feature flag
    ///   - value: The new boolean value to set for the flag
    func updateFlag(identifier: String, value: Bool)

    /// Gets the current value of a specific feature flag
    /// - Parameter identifier: The identifier of the flag to check
    /// - Returns: The boolean value of the flag, or false if the flag doesn't exist
    func value(for identifier: FeatureFlagIdentifier) -> Bool
}

@globalActor actor FeatureFlagsManager: FeatureFlagsManagerProtocol {

    static let shared = FeatureFlagsManager()

    init() {}

    let useCustomChevron: MutableFeatureFlagProtocol = CustomChevronFeatureFlag()
    let displayFaqs: MutableFeatureFlagProtocol = DisplayFAQsFeatureFlag()

    private var allFlags: [MutableFeatureFlagProtocol] {
        [useCustomChevron, displayFaqs]
    }

    func getAllFlags() -> [FeatureFlagProtocol] {
        allFlags.map(FeatureFlag.init)
    }

    func updateFlag(identifier: String, value: Bool) {
        let flagToUpdate = allFlags.first(where: { $0.identifier == identifier })
        flagToUpdate?.setValue(value)
    }

    func value(for identifier: FeatureFlagIdentifier) -> Bool {
        allFlags.first(where: { $0.identifier == identifier.rawValue })?.value ?? false
    }

}
