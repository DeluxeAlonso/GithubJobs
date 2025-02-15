//
//  MockThemeManagerProtocol.swift
//  GithubJobsTests
//
//  Created by Alonso on 28/11/24.
//

@testable import GithubJobs
import Combine
import UIKit

final class MockThemeManagerProtocol: ThemeManagerProtocol {

    var theme: CurrentValueSubject<Theme, Never> = .init(.system)

    private(set) var updateThemeCallCount = 0
    func updateTheme(_ theme: Theme) {
        updateThemeCallCount += 1
    }

}
