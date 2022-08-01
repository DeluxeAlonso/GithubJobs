//
//  SettingsProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import Combine

protocol SettingsViewModelProtocol {

    var itemModelsPublisher: Published<[SettingsItemModel]>.Publisher { get }

}

protocol SettingsCoordinatorProtocol: AnyObject {

    func dismiss()

}
