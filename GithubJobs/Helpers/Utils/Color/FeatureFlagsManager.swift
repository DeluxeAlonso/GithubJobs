//
//  ColorManager.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

// TODO: - Move AppStorage here
struct FeatureFlag {
    let title: String
    let value: Bool
}

@globalActor actor FeatureFlagsManager {

    static let shared = FeatureFlagsManager()

    init() {}

    @AppStorage("GithubJobs_UseCustomChevron")
    private var useCustomChevron: Bool = false

    func updateUseCustomChevron(_ value: Bool) {
        self.useCustomChevron = value
    }

}
