//
//  JobsTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import XCTest
import Combine
@testable import GithubJobs

class JobsTests: XCTestCase {

    private var mockJobClient: MockJobClient!
    private var viewModelToTest: JobsViewModel!

    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockJobClient = MockJobClient()
        viewModelToTest = JobsViewModel(jobClient: mockJobClient)
    }

    override func tearDownWithError() throws {
        mockJobClient = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testGetJobsPaging() {
        // Arrange
        let jobsToTest = [Job.with()]
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        let expectation = XCTestExpectation(description: "State is set to paging")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            state == .paging(jobsToTest, next: 2) ? expectation.fulfill() : XCTFail()
        }.store(in: &cancellables)
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsPopulated() {
        // Arrange
        let jobsToTest = [Job.with()]
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        let expectation = XCTestExpectation(description: "State is set to populated")
        // Act
        viewModelToTest.$viewState.dropFirst(2).sink { state in
            state == .populated(jobsToTest) ? expectation.fulfill() : XCTFail()
        }.store(in: &cancellables)
        viewModelToTest.getJobs()

        mockJobClient.getJobResult = Result.success(JobsResult(jobs: [])).publisher.eraseToAnyPublisher()
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsEmpty() {
        // Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: [])).publisher.eraseToAnyPublisher()
        let expectation = XCTestExpectation(description: "State is set to empty")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            state == .empty ? expectation.fulfill() : XCTFail()
        }.store(in: &cancellables)
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsError() {
        // Arrange
        mockJobClient.getJobResult = Result.failure(APIError.badRequest).publisher.eraseToAnyPublisher()
        let expectation = XCTestExpectation(description: "State is set to error")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            state == .error(APIError.badRequest) ? expectation.fulfill() : XCTFail()
        }.store(in: &cancellables)
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

}
