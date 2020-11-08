//
//  JobsTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import XCTest
@testable import GithubJobs

class JobsTests: XCTestCase {

    var mockJobClient: MockJobClient!
    var viewModelToTest: JobsViewModel!

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

    func testGetJobsPopulated() {
        //Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: [Job.with()]))
        //Act
        viewModelToTest.getJobs()
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: []))
        viewModelToTest.getJobs()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated([Job.with()]))
    }

    func testGetJobsPaging() {
        //Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: [Job.with()]))
        //Act
        viewModelToTest.getJobs()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .paging([Job.with()], next: 2))
    }

    func testGetJobsEmpty() {
        //Arrange
        mockJobClient.getJobResult = Result.success(JobsResult(jobs: []))
        //Act
        viewModelToTest.getJobs()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }

    func testGetJobsError() {
        //Arrange
        mockJobClient.getJobResult = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getJobs()
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }

}
