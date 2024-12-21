//
//  SettingsViewModelTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 23/11/24.
//

import XCTest
import Combine
@testable import GithubJobs

final class SettingsViewModelTests: XCTestCase {

    private var mockInteractor: MockSettingsInteractor!
    private var viewModel: SettingsViewModel!

    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockSettingsInteractor()
        viewModel = SettingsViewModel(interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        viewModel = nil
        try super.tearDownWithError()
    }

    func testScreenTitle() {
        // Act
        let screenTitle = viewModel.screenTitle()
        // Assert
        XCTAssertEqual(screenTitle, "Settings")
    }

    func testLoadItems() async {
        viewModel.sectionModelsPublisher
            .dropFirst()
            .sink { sections in
                XCTAssertEqual(sections.count, 2)
                let mainSection = sections.first
                XCTAssertEqual(mainSection?.items.count, 1)
                XCTAssertEqual(mainSection?.items.first?.title, "Themes")

                let debugSection = sections.last
                XCTAssertEqual(debugSection?.items.count, 1)
                XCTAssertEqual(debugSection?.items.first?.title, "Themes")
        }
        .store(in: &cancellables)
        await viewModel.loadItems()
    }

    func testLoadItemsWithFAQs() async {
        mockInteractor.getFeatureFlagValueResult = true
        viewModel.sectionModelsPublisher
            .dropFirst()
            .sink { sections in
                XCTAssertEqual(sections.count, 2)
                let mainSection = sections.first
                XCTAssertEqual(mainSection?.items.count, 2)
                XCTAssertEqual(mainSection?.items.first?.title, "Themes")
                XCTAssertEqual(mainSection?.items.last?.title, "FAQs")

                let debugSection = sections.last
                XCTAssertEqual(debugSection?.items.count, 1)
                XCTAssertEqual(debugSection?.items.first?.title, "Feature Flags")
        }
        .store(in: &cancellables)
        await viewModel.loadItems()
    }

    func testSelectThemeSelectionItem() async {
        // Arrange
        mockInteractor.getFeatureFlagValueResult = true
        // Act
        viewModel.didUpdateNavigation
            .sink { navigation in
                XCTAssertEqual(navigation, .theme)
            }
            .store(in: &cancellables)
        await viewModel.loadItems()
        viewModel.selectItem(at: 0, and: 0)
    }

    func testSelectFAQsSelectionItem() async {
        mockInteractor.getFeatureFlagValueResult = true
        viewModel.didUpdateNavigation
            .sink { navigation in
                XCTAssertEqual(navigation, .faqs)
            }
            .store(in: &cancellables)
        await viewModel.loadItems()
        viewModel.selectItem(at: 1, and: 0)
    }

    func testSelectFeatureFlagsSelectionItem() async {
        mockInteractor.getFeatureFlagValueResult = true
        viewModel.didUpdateNavigation
            .sink { navigation in
                XCTAssertEqual(navigation, .featureFlags)
            }
            .store(in: &cancellables)
        await viewModel.loadItems()
        viewModel.selectItem(at: 2, and: 0)
    }

}
