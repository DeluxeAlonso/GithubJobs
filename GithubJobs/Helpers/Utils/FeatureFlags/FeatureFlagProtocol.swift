//
//  FeatureFlagProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 5/02/25.
//

/// Protocol defining a read-only feature flag.
/// Feature flags control the visibility and availability of features in the application.
protocol FeatureFlagProtocol: Sendable {

   /// Unique identifier for the feature flag.
   var identifier: String { get }

   /// Human-readable name of the feature flag.
   var title: String { get }

   /// Current state of the feature flag (enabled/disabled).
   var value: Bool { get }

}

/// Protocol defining a mutable feature flag that can be toggled.
/// Extends the read-only functionality with the ability to modify the flag's state.
protocol MutableFeatureFlagProtocol {

   /// Unique identifier for the feature flag.
   var identifier: String { get }

   /// Human-readable name of the feature flag.
   var title: String { get }

   /// Current state of the feature flag (enabled/disabled).
   var value: Bool { get }

   /// Updates the state of the feature flag.
   /// - Parameter value: The new state to apply (true for enabled, false for disabled).
   func setValue(_ value: Bool)

}

/// Immutable implementation of a feature flag.
/// Creates a read-only snapshot of a mutable feature flag.
final class FeatureFlag: FeatureFlagProtocol {
   /// Unique identifier for the feature flag.
   let identifier: String

   /// Human-readable name of the feature flag.
   let title: String

   /// Current state of the feature flag (enabled/disabled).
   let value: Bool

   /// Creates a new immutable feature flag from a mutable feature flag.
   /// - Parameter mutableFeatureFlag: The mutable feature flag to copy.
   init(_ mutableFeatureFlag: MutableFeatureFlagProtocol) {
       self.identifier = mutableFeatureFlag.identifier
       self.title = mutableFeatureFlag.title
       self.value = mutableFeatureFlag.value
   }
}
