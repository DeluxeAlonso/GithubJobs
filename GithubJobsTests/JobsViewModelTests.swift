//
//  JobsViewModelTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import XCTest
import Combine
@testable import GithubJobs

class JobsViewModelTests: XCTestCase {

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
        let jobsToTest = [Job.with()]
        let expectation = XCTestExpectation(description: "State is set to paging")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .paging(jobsToTest, next: 2) ? expectation.fulfill() : XCTFail("State wasn't set to paging")
        }.store(in: &cancellables)
        mockJobsInteractor.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsPopulated() {
        // Arrange
        let jobsToTest = [Job.with()]
        let expectation = XCTestExpectation(description: "State is set to populated")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst(2).sink { state in
            state == .populated(jobsToTest) ? expectation.fulfill() : XCTFail("State wasn't set to populated")
        }.store(in: &cancellables)

        mockJobsInteractor.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        viewModelToTest.getJobs()

        mockJobsInteractor.getJobResult = Result.success(JobsResult(jobs: [])).publisher.eraseToAnyPublisher()
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
    }

    func testGetJobsEmpty() {
        // Arrange
        let jobsToTest: [Job] = []
        let expectation = XCTestExpectation(description: "State is set to empty")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst().sink { state in
            state == .empty ? expectation.fulfill() : XCTFail("State wasn't set to populated")
        }.store(in: &cancellables)
        mockJobsInteractor.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
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
        mockJobsInteractor.getJobResult = Result.failure(errorToTest).publisher.eraseToAnyPublisher()
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
        mockJobsInteractor.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(jobsToTest.count, viewModelToTest.jobsCells.count)
    }

    func testJobCellsCountWhenPopulated() {
        // Arrange
        let jobsToTest = [Job.with()]
        let expectation = XCTestExpectation(description: "State is set to populated")
        // Act
        viewModelToTest.viewStatePublisher.dropFirst(2).sink { state in
            state == .populated(jobsToTest) ? expectation.fulfill() : XCTFail("State wasn't set to populated")
        }.store(in: &cancellables)

        mockJobsInteractor.getJobResult = Result.success(JobsResult(jobs: jobsToTest)).publisher.eraseToAnyPublisher()
        viewModelToTest.getJobs()

        mockJobsInteractor.getJobResult = Result.success(JobsResult(jobs: [])).publisher.eraseToAnyPublisher()
        viewModelToTest.getJobs()
        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(jobsToTest.count, viewModelToTest.jobsCells.count)
    }

    // TODO - Fix unit test
//    func testJobAtIndex() {
//        // Arrange
//        let jobsToTest = [Job.with(id: "1"), Job.with(id: "2")]
//        let viewState = JobsViewState.populated(jobsToTest)
//        Just(viewState).assign(to: &viewModelToTest.viewStatePublisher)
//        // Act
//        let job = viewModelToTest.job(at: 0)
//        // Assert
//        XCTAssertEqual(job.id, jobsToTest.first?.id)
//    }

}
