//
//  JobDetailViewModelTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import XCTest
import Combine
@testable import GithubJobs

class JobDetailViewModelTests: XCTestCase {

    private var jobsInteractor: MockJobsInteractor!
    private var viewModelToTest: JobDetailViewModel!

    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        jobsInteractor = MockJobsInteractor()
        viewModelToTest = JobDetailViewModel(Job.with(id: "1"), interactor: jobsInteractor)
    }

    override func tearDownWithError() throws {
        jobsInteractor = nil
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
        let expectation = XCTestExpectation(description: "State is set to populated")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .populated(jobsToTest) ? expectation.fulfill() : XCTFail("State wasn't set to populated")
        }.store(in: &cancellables)
        jobsInteractor.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        viewModelToTest.getRelatedJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetRelatedJobsEmpty() {
        // Arrange
        let jobsToTest: [Job] = []
        let expectation = XCTestExpectation(description: "State is set to empty")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .empty ? expectation.fulfill() : XCTFail("State wasn't set to empty")
        }.store(in: &cancellables)
        jobsInteractor.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        viewModelToTest.getRelatedJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetRelatedJobsEmptyAfterFilter() {
        // Arrange
        let jobsToTest = [Job.with(id: "1")]
        let expectation = XCTestExpectation(description: "State is set to empty because it solely fetched itself")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .empty ? expectation.fulfill() : XCTFail("State wasn't set to empty")
        }.store(in: &cancellables)
        jobsInteractor.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        viewModelToTest.getRelatedJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsError() {
        // Arrange
        let errorToTest = APIError.badRequest
        let expectation = XCTestExpectation(description: "State is set to error")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .error(message: errorToTest.description) ? expectation.fulfill() : XCTFail("State wasn't set to error")
        }.store(in: &cancellables)
        jobsInteractor.getJobResult = Result<JobsResult, APIError>.failure(APIError.badRequest).publisher.eraseToAnyPublisher()
        viewModelToTest.getRelatedJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

}
