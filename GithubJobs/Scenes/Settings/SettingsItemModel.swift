//
//  SettingsItemModel.swift
//  GithubJobs
//
//  Created by Alonso on 25/07/22.
//

struct SettingsItemModel: Hashable {

    let title: String
    let value: String?
    let actionHandler: (() -> Void)

    init(title: String,
         value: String? = nil,
         actionHandler: @escaping () -> Void) {
        self.title = title
        self.value = value
        self.actionHandler = actionHandler
    }

    static func == (lhs: SettingsItemModel, rhs: SettingsItemModel) -> Bool {
        lhs.title == rhs.title && lhs.value == rhs.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(value)
    }

}

extension SettingsItemModel {

    init?(featureFlagValue: Bool,
          title: String,
          value: String?,
          actionHandler: @escaping (() -> Void)) {
        guard featureFlagValue else { return nil }
        self.title = title
        self.value = value
        self.actionHandler = actionHandler
    }

}
