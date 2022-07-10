//
//  ThemeSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 7/07/22.
//

import Foundation

final class ThemeSelectionViewModel: ThemeSelectionViewModelProtocol {

    private let themeManager: ThemeManagerProtocol

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager
    }

    func title(for theme: Theme) -> String? {
        switch theme {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }

    func headerTitle(for section: Int) -> String? {
        return "Theme"
    }

}
