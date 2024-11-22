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

final class CustomChevronFeatureFlag: FeatureFlagProtocol {

    let identifier: String = "UseCustomChevron"
    let title: String = "User custom chevron view"

    @AppStorage("GithubJobs_UseCustomChevron")
    var value: Bool = false

}

final class DisplayFAQsFeatureFlag: FeatureFlagProtocol {

    let identifier: String = "DisplayFAQs"
    let title: String = "Displays FAQs screen"

    @AppStorage("GithubJobs_DisplayFAQs")
    var value: Bool = false

}

protocol FeatureFlagsManagerProtocol {
    var allFlags: [FeatureFlagProtocol] { get }

    func updateFlag(identifier: String, value: Bool)
}

// TODO: - Convert back this to a @globalActor actor
final class FeatureFlagsManager: FeatureFlagsManagerProtocol {

    static let shared = FeatureFlagsManager()

    init() {}

    private(set) var useCustomChevron: FeatureFlagProtocol = CustomChevronFeatureFlag()
    private(set) var displayFaqs: FeatureFlagProtocol = DisplayFAQsFeatureFlag()

    var allFlags: [FeatureFlagProtocol] {
        [useCustomChevron, displayFaqs]
    }

    func updateFlag(identifier: String, value: Bool) {
        var flagToUpdate = allFlags.first(where: { $0.identifier == identifier })
        flagToUpdate?.value = value
    }

}
