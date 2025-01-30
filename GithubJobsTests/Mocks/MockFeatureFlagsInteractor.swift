//
//  MockFeatureFlagsInteractor.swift
//  GithubJobsTests
//
//  Created by Alonso on 30/01/25.
//

@testable import GithubJobs

final class MockFeatureFlagsInteractor: FeatureFlagsInteractorProtocol {

    var getAllFeatureFlagsResult: Result<[FeatureFlagProtocol], APIError> = .success([])
    private(set) var getAllFeatureFlagsCallCount = 0
    func getAllFeatureFlags() async -> Result<[FeatureFlagProtocol], APIError> {
        getAllFeatureFlagsCallCount += 1
        return getAllFeatureFlagsResult
    }

    private(set) var updateFeatureFlagCallCount = 0
    func updateFeatureFlag(identifier: String, value: Bool) async {
        updateFeatureFlagCallCount += 1
    }

}
