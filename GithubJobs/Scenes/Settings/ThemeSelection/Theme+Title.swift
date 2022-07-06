//
//  Theme+Tile.swift
//  GithubJobs
//
//  Created by Alonso on 5/07/22.
//

extension Theme {

    var title: String? {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }

}
