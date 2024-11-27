//
//  MockSettingsInteractor.swift
//  GithubJobsTests
//
//  Created by Alonso on 26/11/24.
//

import UIKit
@testable import GithubJobs

final class MockSettingsInteractor: SettingsInteractorProtocol {

    var getFeatureFlagValueResult: Bool = false
    private(set) var getFeatureFlagValueCallCount = 0
    func getFeatureFlagValue(for identifier: FeatureFlagIdentifier) async -> Bool {
        getFeatureFlagValueCallCount += 1
        return getFeatureFlagValueResult
    }

    var getCurrentInterfaceStyleResult: UIUserInterfaceStyle = .unspecified
    private(set) var getCurrentInterfaceStyleCallCount = 0
    func getCurrentInterfaceStyle() async -> UIUserInterfaceStyle {
        getCurrentInterfaceStyleCallCount += 1
        return getCurrentInterfaceStyleResult
    }

}
