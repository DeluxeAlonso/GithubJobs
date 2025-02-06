//
//  ColorManager.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

protocol FeatureFlagProtocol {

    var identifier: String { get }
    var title: String { get }
    var value: Bool { get set }

}

protocol FeatureFlagsManagerProtocol: Actor {
    var allFlags: [FeatureFlagProtocol] { get }

    func updateFlag(identifier: String, value: Bool)
    func value(for identifier: FeatureFlagIdentifier) -> Bool
}

@globalActor actor FeatureFlagsManager: FeatureFlagsManagerProtocol {

    static let shared = FeatureFlagsManager()

    init() {}

    let useCustomChevron: FeatureFlagProtocol = CustomChevronFeatureFlag()
    let displayFaqs: FeatureFlagProtocol = DisplayFAQsFeatureFlag()

    nonisolated var allFlags: [FeatureFlagProtocol] {
        [useCustomChevron, displayFaqs]
    }

    func updateFlag(identifier: String, value: Bool) {
        var flagToUpdate = allFlags.first(where: { $0.identifier == identifier })
        flagToUpdate?.value = value
    }

    func value(for identifier: FeatureFlagIdentifier) -> Bool {
        allFlags.first(where: { $0.identifier == identifier.rawValue })?.value ?? false
    }

}
