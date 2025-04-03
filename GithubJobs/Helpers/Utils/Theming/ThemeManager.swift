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

    init() {
        Task {
            await setupTheme()
        }
    }

    // MARK: - Private

    private func setupTheme() {
        themeSubject = CurrentValueSubject<Theme, Never>(storedTheme)
    }

    private var storedTheme: Theme {
        get {
            Theme(rawValue: themeRawValue) ?? .system
        }
        set {
            themeRawValue = newValue.rawValue
            // We update the style subject value.
            themeSubject.value = newValue
        }
    }


    // MARK: - ThemeManagerProtocol

    private(set) var themeSubject: CurrentValueSubject<Theme, Never> = CurrentValueSubject<Theme, Never>(.system)

    var theme: Theme {
        themeSubject.value
    }

    func updateTheme(_ theme: Theme) {
        self.storedTheme = theme
    }

}
