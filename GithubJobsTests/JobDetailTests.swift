//
//  JobDetailTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import XCTest
import Combine
@testable import GithubJobs

class JobDetailTests: XCTestCase {

    private var mockJobClient: MockJobClient!
    private var viewModelToTest: JobDetailViewModel!

    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockJobClient = MockJobClient()

        viewModelToTest = JobDetailViewModel(Job.with(id: "1"), jobClient: mockJobClient)
    }

    override func tearDownWithError() throws {
        mockJobClient = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testJobTitle() {
        // Act
        let title = viewModelToTest.jobTitle
        // Assert
        XCTAssertEqual(title, "Job 1")
    }

    func testGetRelatedJobsPopulated() {
        // Arrange
        let jobsToTest = [Job.with(id: "2")]
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        let expectation = XCTestExpectation(description: "State is set to populated")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            state == .populated(jobsToTest) ? expectation.fulfill() : XCTFail("State wasn't set to populated")
        }.store(in: &cancellables)
        viewModelToTest.getRelatedJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetRelatedJobsEmpty() {
        // Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: [])).publisher.eraseToAnyPublisher()
        let expectation = XCTestExpectation(description: "State is set to empty")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            state == .empty ? expectation.fulfill() : XCTFail("State wasn't set to empty")
        }.store(in: &cancellables)
        viewModelToTest.getRelatedJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetRelatedJobsEmptyAfterFilter() {
        // Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: [Job.with(id: "1")])).publisher.eraseToAnyPublisher()
        let expectation = XCTestExpectation(description: "State is set to empty because it solely fetched itself")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            state == .empty ? expectation.fulfill() : XCTFail("State wasn't set to empty")
        }.store(in: &cancellables)
        viewModelToTest.getRelatedJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsError() {
        // Arrange
        mockJobClient.getJobResult = Result<JobsResult, APIError>.failure(APIError.badRequest).publisher.eraseToAnyPublisher()
        let expectation = XCTestExpectation(description: "State is set to error")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            state == .error(APIError.badRequest) ? expectation.fulfill() : XCTFail("State wasn't set to error")
        }.store(in: &cancellables)
        viewModelToTest.getRelatedJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

}
