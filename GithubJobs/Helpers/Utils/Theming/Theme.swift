//
//  Theme.swift
//  GithubJobs
//
//  Created by Alonso on 5/07/22.
//

import UIKit

enum Theme: Int, CaseIterable, CustomStringConvertible {
    case light, dark, system

    func asUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return .unspecified
        }
    }

    var description: String {
        switch self {
        case .system:
            return "System"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
}
