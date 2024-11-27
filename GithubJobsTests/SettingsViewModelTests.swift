//
//  SettingsViewModelTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 23/11/24.
//

import XCTest
import Combine
@testable import GithubJobs

class SettingsViewModelTests: XCTestCase {

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

}
