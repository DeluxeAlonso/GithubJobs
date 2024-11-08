//
//  ColorSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import Combine

@MainActor
protocol FeatureFlagsViewModelProtocol: ObservableObject {

    var toggles: [FeatureFlagToggleViewModel] { get }

    func load() async

}

final class FeatureFlagsViewModel: FeatureFlagsViewModelProtocol {

    @Published var toggles: [FeatureFlagToggleViewModel] = []

    let featureFlagsManager: FeatureFlagsManagerProtocol

    init(featureFlagsManager: FeatureFlagsManagerProtocol) {
        self.featureFlagsManager = featureFlagsManager

        Task {
            let flags = await featureFlagsManager.allFlags
            self.toggles = flags.map { FeatureFlagToggleViewModel($0) }
        }
    }

    func load() async {
        let flags = await featureFlagsManager.allFlags
        self.toggles = flags.map { FeatureFlagToggleViewModel($0) }
    }

}

// MARK: - Toggle

@MainActor
protocol FeatureFlagToggleViewModelProtocol: ObservableObject {

    var identifier: String { get }
    var title: String { get }
    var value: Bool { get set }

}

final class FeatureFlagToggleViewModel: FeatureFlagToggleViewModelProtocol {

    let identifier: String
    let title: String
    @Published var value: Bool

    init(_ featureFlag: FeatureFlagProtocol) {
        self.identifier = featureFlag.identifier
        self.title = featureFlag.title
        self.value = featureFlag.value
    }

}
