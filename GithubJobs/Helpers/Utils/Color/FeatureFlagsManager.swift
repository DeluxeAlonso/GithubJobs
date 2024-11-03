//
//  ColorManager.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import Foundation

struct FeatureFlag {
    let title: String
    let value: Bool
}

final class FeatureFlagsManager {

    static let shared = FeatureFlagsManager()

    init() {}

}
