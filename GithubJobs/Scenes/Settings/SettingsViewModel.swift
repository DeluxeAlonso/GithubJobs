//
//  SettingsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Combine

final class SettingsViewModel: SettingsViewModelProtocol {

    private let themeManager: ThemeManagerProtocol
    private let featureFlagsManager: FeatureFlagsManagerProtocol

    @Published private var itemModels: [SettingsItemModel] = []

    var itemModelsPublisher: Published<[SettingsItemModel]>.Publisher {
        $itemModels
    }

    private(set) var didUpdateNavigation = PassthroughSubject<SettingsNavigation, Never>()

    init(themeManager: ThemeManagerProtocol,
         featureFlagsManager: FeatureFlagsManagerProtocol) {
        self.themeManager = themeManager
        self.featureFlagsManager = featureFlagsManager
    }

    // MARK: - SettingsViewModelProtocol

    func screenTitle() -> String? {
        return LocalizedStrings.settingsTitle()
    }

    func selectItem(at index: Int) {
        itemModels[index].actionHandler()
    }

    func loadItems() {
        Task {
            itemModels = await createItemModels()
        }
    }

    // MARK: - Private

    private func createItemModels() async -> [SettingsItemModel] {
        [
            SettingsItemModel(title: LocalizedStrings.settingsThemeSelectionRowTitle(),
                              value: themeManager.interfaceStyle.value.description,
                              actionHandler: { [weak self] in self?.navigate(to: .theme) }),
            SettingsItemModel(featureFlagValue: await featureFlagsManager.value(for: .displayFAQs),
                              title: LocalizedStrings.settingsFAQsRowTitle(),
                              value: nil,
                              actionHandler: { [weak self] in self?.navigate(to: .faqs) }),
            SettingsItemModel(title: LocalizedStrings.settingsFeatureFlagRowTitle(),
                              value: nil,
                              actionHandler: { [weak self] in self?.navigate(to: .featureFlags) })
        ].compactMap { $0 }
    }

    private func navigate(to navigation: SettingsNavigation) {
        didUpdateNavigation.send(navigation)
    }

}
