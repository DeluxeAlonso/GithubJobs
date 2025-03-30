//
//  FeatureFlagsInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 15/11/24.
//

protocol FeatureFlagsInteractorProtocol: Sendable {

    func getAllFeatureFlags() async -> Result<[FeatureFlagProtocol], APIError>

    func updateFeatureFlag(identifier: String, value: Bool) async

}

final class FeatureFlagsInteractor: FeatureFlagsInteractorProtocol {

    private let featureFlagsManager: FeatureFlagsManagerProtocol

    init(featureFlagsManager: FeatureFlagsManagerProtocol) {
        self.featureFlagsManager = featureFlagsManager
    }

    func getAllFeatureFlags() async -> Result<[FeatureFlagProtocol], APIError> {
        let flags = await featureFlagsManager.getAllFlags()
        return flags.isEmpty ? .failure(APIError.invalidData) : .success(flags)
    }

    func updateFeatureFlag(identifier: String, value: Bool) async {
        await featureFlagsManager.updateFlag(identifier: identifier, value: value)
    }

}
