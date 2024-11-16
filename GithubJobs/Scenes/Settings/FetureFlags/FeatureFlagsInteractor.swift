//
//  FeatureFlagsInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 15/11/24.
//

import Foundation

protocol FeatureFlagsInteractorProtocol {

    func getAllFeatureFlags() async -> Result<[FeatureFlagProtocol], Error>

    func updateFeatureFlag(identifier: String, value: Bool) async

}

final class FeatureFlagsInteractor: FeatureFlagsInteractorProtocol {

    private let featureFlagsManager: FeatureFlagsManagerProtocol

    init(featureFlagsManager: FeatureFlagsManagerProtocol) {
        self.featureFlagsManager = featureFlagsManager
    }

    func getAllFeatureFlags() async -> Result<[FeatureFlagProtocol], Error> {
        let flags = await featureFlagsManager.allFlags
        return flags.isEmpty ? .failure(APIError.invalidData) : .success(flags)
    }

    func updateFeatureFlag(identifier: String, value: Bool) async {
        await featureFlagsManager.updateFlag(identifier: identifier, value: value)
    }

}
