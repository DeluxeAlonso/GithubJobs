//
//  JobClient.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation
import Combine

final class JobClient: JobClientProtocol, APIClient {

    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func getJobs(page: Int) -> AnyPublisher<JobsResult, APIError> {
        let request = JobProvider.getAll(page: page, description: "").request
        return fetch(with: request) { json -> JobsResult? in
            guard let jobsResult = json as? JobsResult else { return  nil }
            return jobsResult
        }.eraseToAnyPublisher()
    }

    func getJobs(description: String) -> AnyPublisher<JobsResult, APIError> {
        let request = JobProvider.getAll(page: 0, description: description).request
        return fetch(with: request) { json -> JobsResult? in
            guard let jobsResult = json as? JobsResult else { return  nil }
            return jobsResult
        }.eraseToAnyPublisher()
    }

}
