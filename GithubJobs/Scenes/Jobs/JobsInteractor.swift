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

    func getJobs(page: Int) -> AnyPublisher<[Job], APIError> {
        jobsClient
            .getJobs(page: page)
            .map { $0.jobs.map(Job.init) }
            .eraseToAnyPublisher()
    }

    func getJobs(description: String) -> AnyPublisher<[Job], APIError> {
        jobsClient
            .getJobs(description: description)
            .map { $0.jobs.map(Job.init) }
            .eraseToAnyPublisher()
    }

}
