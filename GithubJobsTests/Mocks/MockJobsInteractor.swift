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

    func getJobs(page: Int) -> AnyPublisher<[Job], APIError> {
        getJobResult
    }

    func getJobs(page: Int) async throws -> [Job] {
        jobs
    }

    func getJobs(description: String) -> AnyPublisher<[Job], APIError> {
        getJobResult
    }

    func getJobs(description: String) async throws -> [Job] {
        jobs
    }

}
