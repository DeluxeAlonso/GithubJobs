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
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: jobsToTest))
        let expectation = XCTestExpectation(description: "State is set to paging")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            guard state == .paging(jobsToTest, next: 2) else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }.store(in: &cancellables)
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsPopulated() {
        // Arrange
        let jobsToTest = [Job.with()]
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: jobsToTest))
        let expectation = XCTestExpectation(description: "State is set to populated")
        // Act
        viewModelToTest.$viewState.dropFirst(2).sink { state in
            guard state == .populated(jobsToTest) else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }.store(in: &cancellables)
        viewModelToTest.getJobs()
        // After the first getJobs call, viewState is set to Paging state.
        // We then simulate receiving no jobs after a successfull fetch. In this case
        // the state should change from Paging to Populated.
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: []))
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsEmpty() {
        // Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: []))
        let expectation = XCTestExpectation(description: "State is set to empty")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            guard state == .empty else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }.store(in: &cancellables)
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsError() {
        // Arrange
        mockJobClient.getJobResult = Result.failure(APIError.badRequest)
        let expectation = XCTestExpectation(description: "State is set to error")
        // Act
        viewModelToTest.$viewState.dropFirst().sink { state in
            guard state == .error(APIError.badRequest) else {
                XCTFail()
                return
            }
            expectation.fulfill()
        }.store(in: &cancellables)
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

}
