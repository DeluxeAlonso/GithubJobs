//
//  MockThemeManagerProtocol.swift
//  GithubJobsTests
//
//  Created by Alonso on 28/11/24.
//

@testable import GithubJobs
import Combine
import UIKit

final actor MockThemeManagerProtocol: ThemeManagerProtocol {

    var theme: GithubJobs.Theme = .system

    var themeSubject: CurrentValueSubject<Theme, Never> = .init(.system)

    private(set) var updateThemeCallCount = 0
    func updateTheme(_ theme: Theme) {
        self.theme = theme
        updateThemeCallCount += 1
    }

}
