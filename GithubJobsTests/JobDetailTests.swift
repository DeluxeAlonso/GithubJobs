//
//  JobDetailTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import XCTest
@testable import GithubJobs

class JobDetailTests: XCTestCase {

    var mockJobClient: MockJobClient!
    var viewModelToTest: JobDetailViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockJobClient = MockJobClient()

        let job = Job.with()
        viewModelToTest = JobDetailViewModel(job, jobClient: mockJobClient)
    }

    override func tearDownWithError() throws {
        mockJobClient = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testJobTitle() {
        //Act
        let title = viewModelToTest.jobTitle
        //Assert
        XCTAssertEqual(title, "Job 1")
    }

    func testGetRelatedJobsPopulated() {
        //Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: [Job.with(id: "2")]))
        //Act
        viewModelToTest.getRelatedJobs()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState, .populated([Job.with(id: "2")]))
    }

    func testGetRelatedJobsEmpty() {
        //Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: []))
        //Act
        viewModelToTest.getRelatedJobs()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState, .empty)
    }

    func testGetRelatedJobsEmptyAfterFilter() {
        //Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: [Job.with(id: "1")]))
        //Act
        viewModelToTest.getRelatedJobs()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState, .empty)
    }

    func testGetJobsError() {
        //Arrange
        mockJobClient.getJobResult = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getRelatedJobs()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState, .error(APIError.badRequest))
    }

}
