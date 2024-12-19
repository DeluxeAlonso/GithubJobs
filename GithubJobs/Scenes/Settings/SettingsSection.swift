//
//  SettingsSection.swift
//  GithubJobs
//
//  Created by Alonso on 25/07/22.
//

enum SettingsSection: Hashable {

    case main(items: [SettingsItemModel])
    case debug(items: [SettingsItemModel])

}
