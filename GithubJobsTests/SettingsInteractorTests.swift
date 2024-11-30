//
//  SettingsInteractorTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 29/11/24.
//

import XCTest
import Combine
@testable import GithubJobs

final class SettingsInteractorTests: XCTestCase {

    private var mockThemeManager: MockThemeManagerProtocol!
    private var mockFeatureFlagsManager: MockFeatureFlagsManagerProtocol!
    private var interactor: SettingsInteractor!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockThemeManager = MockThemeManagerProtocol()
        mockFeatureFlagsManager = MockFeatureFlagsManagerProtocol()
        interactor = SettingsInteractor(themeManager: mockThemeManager, featureFlagsManager: mockFeatureFlagsManager)
    }

    override func tearDownWithError() throws {
        mockThemeManager = nil
        mockFeatureFlagsManager = nil
        interactor = nil
        try super.tearDownWithError()
    }

    func testGetCurrentInterfaceStyle() async {
        // Arrange
        mockThemeManager.interfaceStyle = .init(.dark)
        // Act
        let interfaceStyle = await interactor.getCurrentInterfaceStyle()
        // Assert
        XCTAssertEqual(interfaceStyle, .dark)
    }

    func testGetFeatureFlagValue() async {
        // Arrange
        await mockFeatureFlagsManager.setValueForIdentifierResult(true)
        // Act
        let value = await interactor.getFeatureFlagValue(for: .customChevron)
        // Assert
        XCTAssertTrue(value)
    }

}
