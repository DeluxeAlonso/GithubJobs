//
//  MockJobsInteractor.swift
//  GithubJobsTests
//
//  Created by Alonso on 3/01/22.
//

@testable import GithubJobs
import Combine

final class MockJobsInteractor: JobsInteractorProtocol {

    var getJobResult: AnyPublisher<JobsResult, APIError>!

    func getJobs(page: Int) -> AnyPublisher<JobsResult, APIError> {
        return getJobResult
    }

    func getJobs(description: String) -> AnyPublisher<JobsResult, APIError> {
        return getJobResult
    }

}
