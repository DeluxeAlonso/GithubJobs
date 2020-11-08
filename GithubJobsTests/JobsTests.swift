//
//  JobsTests.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import XCTest
@testable import GithubJobs

class JobsTests: XCTestCase {

    var mockJobClient: JobClient!
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

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

private final class MockJobClient: JobClient {

    var getJobResult: Result<JobsResult, APIError>!
    override func getJobs(page: Int, completion: @escaping (Result<JobsResult, APIError>) -> Void) {
        completion(getJobResult)
    }

}
