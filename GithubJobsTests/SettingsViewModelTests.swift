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
        viewModel.itemModelsPublisher
            .dropFirst()
            .sink { items in
                XCTAssertEqual(items.count, 2)
                XCTAssertEqual(items.first?.title, "Themes")
                XCTAssertEqual(items.last?.title, "Feature Flags")

        }
        .store(in: &cancellables)
        await viewModel.loadItems()
    }

    func testLoadItemsWithFAQs() async {
        mockInteractor.getFeatureFlagValueResult = true
        viewModel.itemModelsPublisher
            .dropFirst()
            .sink { items in
                XCTAssertEqual(items.count, 3)
                XCTAssertEqual(items.first?.title, "Themes")
                XCTAssertEqual(items[1].title, "FAQs")
                XCTAssertEqual(items.last?.title, "Feature Flags")
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
