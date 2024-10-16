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

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager

        configure()
    }

    // MARK: - SettingsViewModelProtocol

    func screenTitle() -> String? {
        return LocalizedStrings.settingsTitle()
    }

    func selectItem(at index: Int) {
        itemModels[index].actionHandler?()
    }

    // MARK: - Private

    private func configure() {
        themeManager
            .interfaceStyle
            .map { [weak self] _ -> [SettingsItemModel] in
                guard let self = self else { fatalError("Inconsistent state") }
                return self.createItemModels()
            }
            .assign(to: &$itemModels)
    }

    private func createItemModels() -> [SettingsItemModel] {
        [
            SettingsItemModel(title: LocalizedStrings.settingThemeSelectionRowTitle(),
                              value: themeManager.interfaceStyle.value.description,
                              actionHandler: didTapThemeSelectionItem)
        ]
    }
    
    private func didTapThemeSelectionItem() {
        didSelectThemeSelectionItem.send()
    }
    
}
