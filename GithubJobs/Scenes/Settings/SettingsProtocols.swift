//
//  SettingsProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Combine

protocol SettingsViewModelProtocol {

    var itemModelsPublisher: Published<[SettingsItemModel]>.Publisher { get }
    var didUpdateNavigation: PassthroughSubject<SettingsNavigation, Never> { get }

    func loadItems()

    func screenTitle() -> String?
    func selectItem(at index: Int)

}

protocol SettingsCoordinatorProtocol: AnyObject {

    func startNavigation(for navigation: SettingsNavigation)
    func dismiss()

}
