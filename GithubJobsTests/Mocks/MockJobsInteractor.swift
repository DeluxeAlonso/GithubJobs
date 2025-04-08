//
//  MockJobsInteractor.swift
//  GithubJobsTests
//
//  Created by Alonso on 3/01/22.
//

@testable import GithubJobs
import Combine

final class MockJobsInteractor: JobsInteractorProtocol {

    var getJobResult: AnyPublisher<[Job], APIError>!
    var jobs: [Job] = []
    var error: Error?

    func getJobs(page: Int) -> AnyPublisher<[Job], APIError> {
        getJobResult
    }

    func getJobs(page: Int) async throws -> [Job] {
        if let error {
            throw error
        }
        return jobs
    }

    func getJobs(description: String) -> AnyPublisher<[Job], APIError> {
        getJobResult
    }

    func getJobs(description: String) async throws -> [Job] {
        if let error {
            throw error
        }
        return jobs
    }

}
