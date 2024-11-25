//
//  SettingsInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 23/11/24.
//

import UIKit

final class SettingsInteractor: SettingsInteractorProtocol {

    private let themeManager: ThemeManagerProtocol
    private let featureFlagsManager: FeatureFlagsManagerProtocol

    init(themeManager: ThemeManagerProtocol,
         featureFlagsManager: FeatureFlagsManagerProtocol) {
        self.themeManager = themeManager
        self.featureFlagsManager = featureFlagsManager
    }

    func getFeatureFlagValue(for identifier: FeatureFlagIdentifier) async -> Bool {
        await featureFlagsManager.value(for: identifier)
    }

    func getCurrentInterfaceStyle() async -> UIUserInterfaceStyle {
        themeManager.interfaceStyle.value
    }

}
