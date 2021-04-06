//
//  MockClient.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

@testable import GithubJobs

final class MockJobClient: JobClientProtocol {

    var getJobResult: Result<JobsResult, APIError>!
    func getJobs(page: Int, completion: @escaping (Result<JobsResult, APIError>) -> Void) {
        completion(getJobResult)
    }

    func getJobs(description: String, completion: @escaping (Result<JobsResult, APIError>) -> Void) {
        completion(getJobResult)
    }

}
