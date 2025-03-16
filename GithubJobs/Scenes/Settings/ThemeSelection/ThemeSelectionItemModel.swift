//
//  ThemeSelectionItemModel.swift
//  GithubJobs
//
//  Created by Alonso on 20/07/22.
//

protocol ThemeSelectionItemModelProtocol {

    var theme: Theme { get }
    var isSelected: Bool { get }

}

struct ThemeSelectionItemModel: ThemeSelectionItemModelProtocol, Hashable {

    let theme: Theme
    let isSelected: Bool

    var title: String {
        theme.description
    }

    init(_ theme: Theme, isSelected: Bool) {
        self.theme = theme
        self.isSelected = isSelected
    }

}
