//
//  SettingsItemModel.swift
//  GithubJobs
//
//  Created by Alonso on 25/07/22.
//

import Foundation

enum SettingsItemModel {
    case themes

    var title: String? {
        switch self {
        case .themes:
            return "Themes"
        }
    }
}
