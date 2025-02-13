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

    var interfaceStyle: CurrentValueSubject<UIUserInterfaceStyle, Never> = .init(.unspecified)

    private(set) var updateInterfaceStyleCallCount = 0
    func updateInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle) {
        updateInterfaceStyleCallCount += 1
    }

}
