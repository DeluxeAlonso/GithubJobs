//
//  ThemeSelectionSection.swift
//  GithubJobs
//
//  Created by Alonso on 6/07/22.
//

enum ThemeSelectionSection {
    case main

    var title: String? {
        switch self {
        case .main:
            return "Theme"
        }
    }

    var themes: [Theme] {
        switch self {
        case .main:
            return Theme.allCases
        }
    }
}
