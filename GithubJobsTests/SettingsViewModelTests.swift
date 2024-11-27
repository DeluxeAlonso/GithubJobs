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

    func testLoadItems() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should receive items")
        // Act
        viewModel.itemModelsPublisher
            .dropFirst()
            .sink { items in
                XCTAssertEqual(items.count, 2)
                XCTAssertEqual(items.first?.title, "Themes")
                XCTAssertEqual(items.last?.title, "Feature Flags")
                expectation.fulfill()
        }
        .store(in: &cancellables)
        viewModel.loadItems()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testLoadItemsWithFAQs() {
        // Arrange
        let expectation = XCTestExpectation(description: "Should receive items")
        mockInteractor.getFeatureFlagValueResult = true
        // Act
        viewModel.itemModelsPublisher
            .dropFirst()
            .sink { items in
                XCTAssertEqual(items.count, 3)
                XCTAssertEqual(items.first?.title, "Themes")
                XCTAssertEqual(items[1].title, "FAQs")
                XCTAssertEqual(items.last?.title, "Feature Flags")
                expectation.fulfill()
        }
        .store(in: &cancellables)
        viewModel.loadItems()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testSelectThemeSelectionItem() {
        // Arrange
        let expectation = XCTestExpectation(description: "Theme selection item was selected")
        mockInteractor.getFeatureFlagValueResult = true
        let selectThemeSelectionItemIndex = { self.viewModel.selectItem(at: 0) }
        // Act
        viewModel.itemModelsPublisher
            .dropFirst()
            .delay(for: 0.1, scheduler: RunLoop.current)
            .sink { items in
                XCTAssertEqual(items.count, 3)
                selectThemeSelectionItemIndex()
        }
        .store(in: &cancellables)

        viewModel.didUpdateNavigation
            .sink { navigation in
                XCTAssertEqual(navigation, .theme)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.loadItems()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testSelectFAQsSelectionItem() {
        // Arrange
        let expectation = XCTestExpectation(description: "FAQs item was selected")
        mockInteractor.getFeatureFlagValueResult = true
        let selectFAQsItemIndex = { self.viewModel.selectItem(at: 1) }
        // Act
        viewModel.itemModelsPublisher
            .dropFirst()
            .delay(for: 0.1, scheduler: RunLoop.current)
            .sink { items in
                XCTAssertEqual(items.count, 3)
                selectFAQsItemIndex()
        }
        .store(in: &cancellables)

        viewModel.didUpdateNavigation
            .sink { navigation in
                XCTAssertEqual(navigation, .faqs)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.loadItems()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testSelectFeatureFlagsSelectionItem() {
        // Arrange
        let expectation = XCTestExpectation(description: "Feature Flags item was selected")
        mockInteractor.getFeatureFlagValueResult = true
        let selectFAQsItemIndex = { self.viewModel.selectItem(at: 2) }
        // Act
        viewModel.itemModelsPublisher
            .dropFirst()
            .delay(for: 0.1, scheduler: RunLoop.current)
            .sink { items in
                XCTAssertEqual(items.count, 3)
                selectFAQsItemIndex()
        }
        .store(in: &cancellables)

        viewModel.didUpdateNavigation
            .sink { navigation in
                XCTAssertEqual(navigation, .featureFlags)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.loadItems()
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

}
