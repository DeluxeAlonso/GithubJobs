//
//  JobsInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 2/01/22.
//

import Combine

final class JobsInteractor: JobsInteractorProtocol {

    private let jobClient: JobClientProtocol

    init(jobClient: JobClientProtocol) {
        self.jobClient = jobClient
    }

    func getJobs(page: Int) -> AnyPublisher<JobsResult, APIError> {
        jobClient.getJobs(page: page)
    }

    func getJobs(description: String) -> AnyPublisher<JobsResult, APIError> {
        jobClient.getJobs(description: description)
    }

}
