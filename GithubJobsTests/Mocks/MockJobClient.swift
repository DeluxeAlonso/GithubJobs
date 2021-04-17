//
//  MockClient.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

@testable import GithubJobs
import Combine

final class MockJobClient: JobClientProtocol {

    var getJobResult: AnyPublisher<JobsResult, APIError>!
    func getJobs(page: Int) -> AnyPublisher<JobsResult, APIError> {
        return getJobResult
    }

    func getJobs(description: String) -> AnyPublisher<JobsResult, APIError> {
        return getJobResult
    }


    //    var getJobResult: Result<JobsResult, APIError>!
    //    func getJobs(page: Int, completion: @escaping (Result<JobsResult, APIError>) -> Void) {
//        completion(getJobResult)
//    }
//
//    func getJobs(description: String, completion: @escaping (Result<JobsResult, APIError>) -> Void) {
//        completion(getJobResult)
//    }

}
