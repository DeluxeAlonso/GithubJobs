//
//  ColorSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import Combine

final class ColorSelectionViewModel: ObservableObject {

    let colorManager: ColorManager

    init(colorManager: ColorManager) {
        self.colorManager = colorManager
    }

}
