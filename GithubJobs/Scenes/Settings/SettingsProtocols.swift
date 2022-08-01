//
//  SettingsProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Combine

protocol SettingsViewModelProtocol {

    var itemModelsPublisher: Published<[SettingsItemModel]>.Publisher { get }
    var didSelectThemeSelectionItem: PassthroughSubject<Void, Never> { get }

    func selectItem(at index: Int)

}

protocol SettingsCoordinatorProtocol: AnyObject {

    func showThemeSelection()
    func dismiss()

}
