//
//  SettingsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Combine
import Foundation

final class SettingsViewModel: SettingsViewModelProtocol {

    private let themeManager: ThemeManagerProtocol

    @Published var itemModels: [SettingsItemModel] = []

    var itemModelsPublisher: Published<[SettingsItemModel]>.Publisher {
        $itemModels
    }

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager

        configure()
    }

    private func configure() {
        themeManager
            .interfaceStyle
            .map { [weak self] _ -> [SettingsItemModel] in
                guard let self = self else { fatalError() }
                return self.createItemModels()
            }
            .assign(to: &$itemModels)
    }

    private func createItemModels() -> [SettingsItemModel] {
        return [
            SettingsItemModel(title: "Themes", value: themeManager.interfaceStyle.value.description)
        ]
    }
    
}
