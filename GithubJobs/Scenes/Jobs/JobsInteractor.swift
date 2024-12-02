//
//  JobsInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 2/01/22.
//

import Combine

final class JobsInteractor: JobsInteractorProtocol {

    private let jobsClient: JobsClientProtocol

    init(jobsClient: JobsClientProtocol) {
        self.jobsClient = jobsClient
    }

    func getJobs(page: Int) -> AnyPublisher<JobsResult, APIError> {
        jobsClient.getJobs(page: page)
    }

    func getJobs(description: String) -> AnyPublisher<JobsResult, APIError> {
        jobsClient.getJobs(description: description)
    }

}
