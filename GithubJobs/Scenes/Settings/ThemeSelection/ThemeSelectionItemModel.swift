//
//  ThemeSelectionItemModel.swift
//  GithubJobs
//
//  Created by Alonso on 20/07/22.
//

struct ThemeSelectionItemModel: Hashable {

    let theme: Theme
    let isSelected: Bool

    var title: String {
        theme.asUserInterfaceStyle().description
    }

    init(_ theme: Theme, isSelected: Bool) {
        self.theme = theme
        self.isSelected = isSelected
    }

}
