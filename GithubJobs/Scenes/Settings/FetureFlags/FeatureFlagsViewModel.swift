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

    let colorManager: FeatureFlagsManager

    init(colorManager: FeatureFlagsManager) {
        self.colorManager = colorManager
    }

}

// MARK: - Item

struct FeatureFlagItemViewModel {

}
