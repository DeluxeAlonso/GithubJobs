//
//  SettingsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Combine

final class SettingsViewModel: SettingsViewModelProtocol {

    private let interactor: SettingsInteractorProtocol

    @Published private var sectionModels: [SettingsSection] = []

    var itemModelsPublisher: Published<[SettingsItemModel]>.Publisher {
        $sectionModels
    }

    private(set) var didUpdateNavigation = PassthroughSubject<SettingsNavigation, Never>()

    init(interactor: SettingsInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - SettingsViewModelProtocol

    func screenTitle() -> String? {
        return LocalizedStrings.settingsTitle()
    }

    func selectItem(at index: Int) {
        sectionModels[index].actionHandler()
    }

    func loadItems() async {
        sectionModels = await createItemModels()
    }

    // MARK: - Private

    private func createItemModels() async -> [SettingsItemModel] {
        [
            SettingsItemModel(title: LocalizedStrings.settingsThemeSelectionRowTitle(),
                              value: await interactor.getCurrentInterfaceStyle().description,
                              actionHandler: { [weak self] in self?.navigate(to: .theme) }),
            SettingsItemModel(featureFlagValue: await interactor.getFeatureFlagValue(for: .displayFAQs),
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
