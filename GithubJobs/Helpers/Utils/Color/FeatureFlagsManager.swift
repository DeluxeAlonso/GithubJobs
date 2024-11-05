//
//  ColorManager.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

protocol FeatureFlagProtocol {

    var title: String { get }
    var value: Bool { get set }

}

struct CustomChevronFeatureFlag: FeatureFlagProtocol {

    let title: String = "User custom chevron view"

    @AppStorage("GithubJobs_UseCustomChevron")
    var value: Bool = false

}

@globalActor actor FeatureFlagsManager {

    static let shared = FeatureFlagsManager()

    init() {}

    private var useCustomChevron: FeatureFlagProtocol = CustomChevronFeatureFlag()

    func updateUseCustomChevron(_ value: Bool) {
        self.useCustomChevron.value = value
    }

}
