//
//  ColorManager.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

protocol FeatureFlagsManagerProtocol: Actor {
    func getAllFlags() -> [FeatureFlagProtocol]
    func updateFlag(identifier: String, value: Bool)
    func value(for identifier: FeatureFlagIdentifier) -> Bool
}

@globalActor actor FeatureFlagsManager: FeatureFlagsManagerProtocol {

    static let shared = FeatureFlagsManager()

    init() {}

    let useCustomChevron: MutableFeatureFlagProtocol = MutableCustomChevronFeatureFlag()
    let displayFaqs: MutableFeatureFlagProtocol = DisplayFAQsFeatureFlag()

    private var allFlags: [MutableFeatureFlagProtocol] {
        [useCustomChevron, displayFaqs]
    }

    func getAllFlags() -> [FeatureFlagProtocol] {
        allFlags.map(FeatureFlag.init)
    }

    func updateFlag(identifier: String, value: Bool) {
        var flagToUpdate = allFlags.first(where: { $0.identifier == identifier })
        flagToUpdate?.setValue(value)
    }

    func value(for identifier: FeatureFlagIdentifier) -> Bool {
        allFlags.first(where: { $0.identifier == identifier.rawValue })?.value ?? false
    }

}
