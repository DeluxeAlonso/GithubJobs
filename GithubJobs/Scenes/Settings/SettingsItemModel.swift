//
//  SettingsItemModel.swift
//  GithubJobs
//
//  Created by Alonso on 25/07/22.
//

struct SettingsItemModel: Hashable {

    let title: String
    let value: String?
    let actionHandler: (() -> Void)?

    static func == (lhs: SettingsItemModel, rhs: SettingsItemModel) -> Bool {
        lhs.title == rhs.title && lhs.value == rhs.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(value)
    }

}
