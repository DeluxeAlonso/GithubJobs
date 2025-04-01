//
//  MockSettingsInteractor.swift
//  GithubJobsTests
//
//  Created by Alonso on 26/11/24.
//

import UIKit
@testable import GithubJobs

final class MockSettingsInteractor: @unchecked Sendable, SettingsInteractorProtocol {

    var getFeatureFlagValueResult: Bool = false
    private(set) var getFeatureFlagValueCallCount = 0
    func getFeatureFlagValue(for identifier: FeatureFlagIdentifier) async -> Bool {
        getFeatureFlagValueCallCount += 1
        return getFeatureFlagValueResult
    }

    var getCurrentThemeResult: Theme = .system
    private(set) var getCurrentThemeCallCount = 0
    func getCurrentTheme() async -> GithubJobs.Theme {
        getCurrentThemeCallCount += 1
        return getCurrentThemeResult
    }

}
