//
//  JobsViewModelTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import XCTest
import Combine
@testable import GithubJobs

@MainActor
final class JobsViewModelTests: XCTestCase {

    private var mockJobsInteractor: MockJobsInteractor!
    private var viewModelToTest: JobsViewModel!

    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockJobsInteractor = MockJobsInteractor()
        viewModelToTest = JobsViewModel(interactor: mockJobsInteractor)
    }

    override func tearDownWithError() throws {
        mockJobsInteractor = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testGetJobsPaging() {
        // Arrange
        let expectation = XCTestExpectation(description: "State is set to paging")

        let jobsToTest = [Job.with()]
        mockJobsInteractor.jobs = jobsToTest
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .paging(jobsToTest, next: 2) ? expectation.fulfill() : XCTFail("State wasn't set to paging")
        }.store(in: &cancellables)
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsPopulated() async throws {
        // Arrange
        let jobsToTest = [Job.with()]
        mockJobsInteractor.jobs = jobsToTest
        let expectation = XCTestExpectation(description: "State is set to populated")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst(2).sink { state in
            state == .populated(jobsToTest) ? expectation.fulfill() : XCTFail("State wasn't set to populated")
        }.store(in: &cancellables)
        viewModelToTest.getJobs()

        try await Task.sleep(nanoseconds: 100_000_000)

        mockJobsInteractor.jobs = []
        viewModelToTest.getJobs()
        // Assert
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testGetJobsEmpty() {
        // Arrange
        let jobsToTest: [Job] = []
        let expectation = XCTestExpectation(description: "State is set to empty")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .empty ? expectation.fulfill() : XCTFail("State wasn't set to populated")
        }.store(in: &cancellables)
        mockJobsInteractor.jobs = jobsToTest
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsError() {
        // Arrange
        let errorToTest = APIError.badRequest
        let expectation = XCTestExpectation(description: "State is set to error")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .error(message: APIError.badRequest.description) ? expectation.fulfill() : XCTFail("State wasn't set to error")
        }.store(in: &cancellables)
        mockJobsInteractor.error = errorToTest
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testJobCellsCountWhenPaging() {
        // Arrange
        let jobsToTest = [Job.with()]
        let expectation = XCTestExpectation(description: "State is set to paging")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .paging(jobsToTest, next: 2) ? expectation.fulfill() : XCTFail("State wasn't set to paging")
        }.store(in: &cancellables)
        mockJobsInteractor.jobs = jobsToTest
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(jobsToTest.count, viewModelToTest.jobsCells.count)
    }

    func testJobCellsCountWhenPopulated() async throws {
        // Arrange
        let jobsToTest = [Job.with()]
        mockJobsInteractor.jobs = jobsToTest
        let expectation = XCTestExpectation(description: "State is set to populated")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst(2).sink { state in
            state == .populated(jobsToTest) ? expectation.fulfill() : XCTFail("State wasn't set to populated")
        }.store(in: &cancellables)
        viewModelToTest.getJobs()

        try await Task.sleep(nanoseconds: 100_000_000)

        mockJobsInteractor.jobs = []
        viewModelToTest.getJobs()
        // Assert
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(jobsToTest.count, viewModelToTest.jobsCells.count)
    }

    func testJobAtIndex() {
        // Arrange
        let jobsToTest = [Job.with(id: "1"), Job.with(id: "2")]
        let expectation = XCTestExpectation(description: "State is set to paging")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .paging(jobsToTest, next: 2) ? expectation.fulfill() : XCTFail("State wasn't set to paging")
        }.store(in: &cancellables)
        mockJobsInteractor.jobs = jobsToTest
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
        let job = viewModelToTest.job(at: 0)
        XCTAssertEqual(job.id, jobsToTest.first?.id)
    }

}
