//
//  ThemeSelectionItemModel.swift
//  GithubJobs
//
//  Created by Alonso on 20/07/22.
//

struct ThemeSelectionItemModel: Hashable {

    let theme: Theme
    let isSelected: Bool

    init(_ theme: Theme, isSelected: Bool) {
        self.theme = theme
        self.isSelected = isSelected
    }

    var title: String {
        switch theme {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }

}
