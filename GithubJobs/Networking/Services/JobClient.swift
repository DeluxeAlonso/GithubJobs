//
//  JobClient.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

class JobClient: JobClientProtocol, APIClient {

    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func getJobs(page: Int, completion: @escaping (Result<JobsResult, APIError>) -> Void) {
        let request = JobProvider.getAll(page: page).request
        fetch(with: request, decode: { json -> JobsResult? in
            guard let jobsResult = json as? JobsResult else { return  nil }
            return jobsResult
        }, completion: completion)
    }

}
