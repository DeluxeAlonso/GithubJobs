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

protocol FeatureFlagsManagerProtocol: Actor {
    var allFlags: [FeatureFlagProtocol] { get }

    func updateFlag(identifier: String, value: Bool)
}

@globalActor actor FeatureFlagsManager: FeatureFlagsManagerProtocol {

    static let shared = FeatureFlagsManager()

    init() {}

    private var useCustomChevron: FeatureFlagProtocol = CustomChevronFeatureFlag()

    var allFlags: [FeatureFlagProtocol] {
        [useCustomChevron]
    }

    func updateFlag(identifier: String, value: Bool) {
        var flagToUpdate = allFlags.first(where: { $0.identifier == identifier })
        flagToUpdate?.value = value
    }

}
