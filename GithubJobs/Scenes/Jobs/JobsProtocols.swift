//
//  JobsProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine

@MainActor
protocol JobsViewModelProtocol {

    var viewStatePublisher: Published<JobsViewState>.Publisher { get }
    var needsPrefetch: Bool { get }

    var jobsCells: [JobCellViewModel] { get }

    func getJobs()
    func refreshJobs()

    func job(at index: Int) -> Job

}

protocol JobsInteractorProtocol: Sendable {

    func getJobs(page: Int) -> AnyPublisher<[Job], APIError>
    func getJobs(page: Int) async throws -> [Job]

    func getJobs(description: String) -> AnyPublisher<[Job], APIError>
    func getJobs(description: String) async throws -> [Job]

}

@MainActor
protocol JobsCoordinatorProtocol: Coordinator {

    func showJobDetail(_ job: Job)
    func showSettings()

}
