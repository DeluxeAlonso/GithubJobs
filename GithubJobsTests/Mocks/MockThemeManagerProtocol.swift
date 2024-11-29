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

    var interfaceStyle: CurrentValueSubject<UIUserInterfaceStyle, Never> = .init(.unspecified)

    private(set) var updateInterfaceStyleCallCount = 0
    func updateInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle) {
        updateInterfaceStyleCallCount += 1
    }

}
