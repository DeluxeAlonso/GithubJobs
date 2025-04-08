//
//  FAQsViewModelTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 18/01/25.
//

import XCTest
import Combine
@testable import GithubJobs

@MainActor
final class FAQsViewModelTests: XCTestCase {

    private var mockInteractor: MockFAQsInteractor!
    private var viewModel: FAQsViewModel!

    private var cancellables: Set<AnyCancellable> = []

    override func setUp() async throws {
        mockInteractor = MockFAQsInteractor()
        viewModel = FAQsViewModel(interactor: mockInteractor, hostingConfiguration: HostingConfiguration())
    }

    override func tearDown() async throws {
        mockInteractor = nil
        viewModel = nil
    }

    func testLoadSuccess() async throws {
        // Arrange
        let faqsExpectation = expectation(description: "We should retrieve FAQs models")
        let stateExpectation = expectation(description: "State is set to populated")
        let faqs = [
            FAQ(id: "ID", title: "Title", descriptions: ["Description"]),
            FAQ(id: "ID2", title: "Title2", descriptions: ["Description2"])
        ]
        mockInteractor.getAllFAQsResult = .success(faqs)
        // Act
        viewModel.$items
            .dropFirst()
            .sink { faqs in
                XCTAssertEqual(faqs.count, 2)
                faqsExpectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.$viewState
            .dropFirst(2)
            .sink { state in
                XCTAssertEqual(state, .populated)
                stateExpectation.fulfill()
            }
            .store(in: &cancellables)
        await viewModel.load()
        // Assert
        await fulfillment(of: [faqsExpectation, stateExpectation], timeout: 1.0)
    }

    func testLoadError() async throws {
        // Arrange
        let errorModelExpectation = expectation(description: "We should get an error view model")
        let stateExpectation = expectation(description: "State is set to error")
        mockInteractor.getAllFAQsResult = .failure(.badRequest)
        // Act
        viewModel.$items
            .dropFirst()
            .sink { _ in
                XCTFail("We should not get any FAQs item")
            }
            .store(in: &cancellables)
        viewModel.$errorViewModel
            .dropFirst()
            .sink { errorViewModel in
                XCTAssertNotNil(errorViewModel)
                errorModelExpectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.$viewState
            .dropFirst(2)
            .sink { state in
                XCTAssertEqual(state, .error)
                stateExpectation.fulfill()
            }
            .store(in: &cancellables)
        await viewModel.load()
        // Assert
        await fulfillment(of: [errorModelExpectation, stateExpectation], timeout: 1.0)
    }

    func testVerticalSpacing() {
        // Act
        let verticalSpacing = viewModel.verticalSpacing
        // Assert
        XCTAssertEqual(verticalSpacing, 16.0)
    }

    func testTopPadding() {
        // Act
        let topPadding = viewModel.topPadding
        // Assert
        XCTAssertEqual(topPadding, 24.0)
    }

}
