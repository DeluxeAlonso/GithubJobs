//
//  MockFeatureFlagsManagerProtocol.swift
//  GithubJobsTests
//
//  Created by Alonso on 28/11/24.
//

@testable import GithubJobs

final actor MockFeatureFlagsManagerProtocol: FeatureFlagsManagerProtocol {
    
    var allFlags: [FeatureFlagProtocol] = []

    private(set) var getAllFlagsCallCount = 0
    func getAllFlags() -> [any FeatureFlagProtocol] {
        getAllFlagsCallCount += 1
        return allFlags
    }

    private(set) var updateFlagCallCount = 0
    func updateFlag(identifier: String, value: Bool) {
        updateFlagCallCount += 1
    }

    private(set) var valueForIdentifierResult = false
    func setValueForIdentifierResult(_ value: Bool) {
        valueForIdentifierResult = value
    }

    private(set) var valueForIdentifierCallCount = 0
    func value(for identifier: FeatureFlagIdentifier) -> Bool {
        valueForIdentifierCallCount += 1
        return valueForIdentifierResult
    }

}
