//
//  ColorSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import Combine

@MainActor
protocol FeatureFlagsViewModelProtocol: ObservableObject {

    var items: [FeatureFlagItemViewModel] { get }

}

final class FeatureFlagsViewModel: FeatureFlagsViewModelProtocol {

    @Published var items: [FeatureFlagItemViewModel] = []

    let featureFlagsManager: FeatureFlagsManagerProtocol

    init(featureFlagsManager: FeatureFlagsManagerProtocol) {
        self.featureFlagsManager = featureFlagsManager

        Task {
            let flags = await featureFlagsManager.allFlags
            self.items = flags.map { FeatureFlagItemViewModel($0) }
        }
    }

}

// MARK: - Item

struct FeatureFlagItemViewModel {

    let title: String
    let value: Bool

    init(_ featureFlag: FeatureFlagProtocol) {
        self.title = featureFlag.title
        self.value = featureFlag.value
    }

}
