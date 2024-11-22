//
//  SettingsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Combine

final class SettingsViewModel: SettingsViewModelProtocol {

    private let themeManager: ThemeManagerProtocol

    @Published private var itemModels: [SettingsItemModel] = []

    var itemModelsPublisher: Published<[SettingsItemModel]>.Publisher {
        $itemModels
    }

    private(set) var didSelectThemeSelectionItem = PassthroughSubject<Void, Never>()
    private(set) var didSelectFeatureFlagsItem = PassthroughSubject<Void, Never>()
    private(set) var didSelectFAQsItem = PassthroughSubject<Void, Never>()

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager
    }

    // MARK: - SettingsViewModelProtocol

    func screenTitle() -> String? {
        return LocalizedStrings.settingsTitle()
    }

    func selectItem(at index: Int) {
        itemModels[index].actionHandler?()
    }

    func loadItems() {
        Task {
            itemModels = await createItemModels()
        }
    }

    // MARK: - Private

    private func createItemModels() async -> [SettingsItemModel] {
        [
            SettingsItemModel(title: LocalizedStrings.settingThemeSelectionRowTitle(),
                              value: themeManager.interfaceStyle.value.description,
                              actionHandler: didTapThemeSelectionItem),
            SettingsItemModel(featureFlagValue: await FeatureFlagsManager.shared.value(for: .displayFAQs),
                              title: "FAQs",
                              value: nil,
                              actionHandler: didTapFAQsSelectionItem),
            SettingsItemModel(title: LocalizedStrings.settingFeatureFlagRowTitle(),
                              value: nil,
                              actionHandler: didTapFeatureFlagsItem)
        ].compactMap { $0 }
    }

    private func didTapFeatureFlagsItem() {
        didSelectFeatureFlagsItem.send()
    }
    
    private func didTapThemeSelectionItem() {
        didSelectThemeSelectionItem.send()
    }

    private func didTapFAQsSelectionItem() {
        didSelectFAQsItem.send()
    }
    
}
