//
//  ColorSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import Combine

final class FeatureFlagsViewModel: ObservableObject {

    let colorManager: FeatureFlagsManager

    init(colorManager: FeatureFlagsManager) {
        self.colorManager = colorManager
    }

}
