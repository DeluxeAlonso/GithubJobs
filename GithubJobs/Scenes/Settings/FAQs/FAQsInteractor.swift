//
//  FAQsInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 30/11/24.
//

import Foundation

protocol FAQsInteractorProtocol {

    func getAllFlags() async -> [FeatureFlagProtocol]

}

final class FAQsInteractor: FAQsInteractorProtocol {

    private let featureFlagsManager: FeatureFlagsManagerProtocol

    init(featureFlagsManager: FeatureFlagsManagerProtocol) {
        self.featureFlagsManager = featureFlagsManager
    }

    func getAllFlags() async -> [FeatureFlagProtocol] {
        await featureFlagsManager.allFlags
    }

}
