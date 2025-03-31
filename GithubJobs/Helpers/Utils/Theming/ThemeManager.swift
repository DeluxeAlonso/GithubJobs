//
//  ThemeManager.swift
//  GithubJobs
//
//  Created by Alonso on 24/04/21.
//

import Combine
import SwiftUI

@globalActor actor ThemeManager: ThemeManagerProtocol {

    static let shared = ThemeManager()

    @AppStorage("Theme")
    private var themeRawValue: Int = Theme.system.rawValue

    init() {}

    // MARK: - ThemeManagerProtocol

    private(set) var theme: CurrentValueSubject<Theme, Never> = CurrentValueSubject<Theme, Never>(.system)

    func updateTheme(_ theme: Theme) {
        self.storedTheme = theme
    }

    // MARK: - Private

    private var storedTheme: Theme {
        get {
            Theme(rawValue: themeRawValue) ?? .system
        }
        set {
            themeRawValue = newValue.rawValue
            // We update the style subject value.
            theme.value = newValue
        }
    }

}
