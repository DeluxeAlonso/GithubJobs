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

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockFAQsInteractor()
        viewModel = FAQsViewModel(interactor: mockInteractor, hostingConfiguration: HostingConfiguration())
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        viewModel = nil
        try super.tearDownWithError()
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
