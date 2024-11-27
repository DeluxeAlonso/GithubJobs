//
//  SettingsProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Combine
import UIKit

protocol SettingsViewModelProtocol {

    var itemModelsPublisher: Published<[SettingsItemModel]>.Publisher { get }
    var didUpdateNavigation: PassthroughSubject<SettingsNavigation, Never> { get }

    func loadItems() async

    func screenTitle() -> String?
    func selectItem(at index: Int)

}

protocol SettingsCoordinatorProtocol: AnyObject {

    func startNavigation(for navigation: SettingsNavigation)
    func dismiss()

}

protocol SettingsInteractorProtocol {
    func getFeatureFlagValue(for identifier: FeatureFlagIdentifier) async -> Bool
    func getCurrentInterfaceStyle() async -> UIUserInterfaceStyle
}
