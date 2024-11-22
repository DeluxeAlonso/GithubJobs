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

enum FeatureFlagIdentifier: String {
    case displayFAQs = "DisplayFAQs"
    case customChevron = "UseCustomChevron"
}

final class CustomChevronFeatureFlag: FeatureFlagProtocol {

    let identifier: String = FeatureFlagIdentifier.customChevron.rawValue
    let title: String = "User custom chevron view"

    @AppStorage("GithubJobs_UseCustomChevron")
    var value: Bool = false

}

final class DisplayFAQsFeatureFlag: FeatureFlagProtocol {

    let identifier: String = FeatureFlagIdentifier.displayFAQs.rawValue
    let title: String = "Displays FAQs screen"

    @AppStorage("GithubJobs_DisplayFAQs")
    var value: Bool = false

}

protocol FeatureFlagsManagerProtocol: Actor {
    var allFlags: [FeatureFlagProtocol] { get }

    func updateFlag(identifier: String, value: Bool)
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

    nonisolated func value(for identifier: String) -> Bool {
        allFlags.first(where: { $0.identifier == identifier })?.value ?? false
    }

}
