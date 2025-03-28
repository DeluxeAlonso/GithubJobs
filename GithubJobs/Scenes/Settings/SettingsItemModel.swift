//
//  SettingsItemModel.swift
//  GithubJobs
//
//  Created by Alonso on 25/07/22.
//

struct SettingsItemModel: Hashable, Sendable {

    let title: String
    let value: String?
    let actionHandler: @Sendable () -> Void

    init(title: String,
         value: String? = nil,
         actionHandler: @escaping @Sendable () -> Void) {
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
          actionHandler: @escaping @Sendable () -> Void) {
        guard featureFlagValue else { return nil }
        self.title = title
        self.value = value
        self.actionHandler = actionHandler
    }

}
