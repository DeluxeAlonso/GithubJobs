//
//  JobsClient.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation
import Combine

final class JobsClient: JobsClientProtocol, APIClient {

    let session: URLSession

    // MARK: - Initializers

    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    // MARK: - JobsClientProtocol

    func getJobs(page: Int) -> AnyPublisher<JobsResult, APIError> {
        getJobs(page: page, description: "")
    }

    func getJobs(page: Int) async throws -> JobsResult {
        try await getJobs(page: page, description: "")
    }

    func getJobs(description: String) -> AnyPublisher<JobsResult, APIError> {
        getJobs(page: 0, description: description)
    }

    func getJobs(description: String) async throws -> JobsResult {
        try await getJobs(page: 0, description: description)
    }

    private func getJobs(page: Int, description: String) -> AnyPublisher<JobsResult, APIError> {
        let request = JobsProvider.getAll(page: page, description: description).request
        return fetch(with: request) { json -> JobsResult? in
            guard let jobsResult = json as? JobsResult else { return  nil }
            return jobsResult
        }.eraseToAnyPublisher()
    }

    private func getJobs(page: Int, description: String) async throws -> JobsResult {
        let request = JobsProvider.getAll(page: page, description: description).request
        return try await fetch(with: request, decodingType: JobsResult.self)
    }

}
