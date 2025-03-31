//
//  SettingsProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Combine
import UIKit

@MainActor
protocol SettingsViewModelProtocol {

    var sectionModelsPublisher: Published<[SettingsSection]>.Publisher { get }
    var didUpdateNavigation: PassthroughSubject<SettingsNavigation, Never> { get }

    func loadItems() async

    func screenTitle() -> String?
    func selectItem(at index: Int, and section: Int)

}

@MainActor
protocol SettingsCoordinatorProtocol: AnyObject {

    func startNavigation(for navigation: SettingsNavigation)
    func dismiss()

}

protocol SettingsInteractorProtocol: Sendable {

    func getFeatureFlagValue(for identifier: FeatureFlagIdentifier) async -> Bool
    func getCurrentTheme() async -> Theme 

}
