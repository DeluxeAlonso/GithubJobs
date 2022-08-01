//
//  JobsProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine

protocol JobsViewModelProtocol {

    var viewStatePublisher: Published<JobsViewState>.Publisher { get }
    var needsPrefetch: Bool { get }

    var jobsCells: [JobCellViewModel] { get }

    func getJobs()
    func job(at index: Int) -> Job

}

protocol JobsInteractorProtocol {

    func getJobs(page: Int) -> AnyPublisher<JobsResult, APIError>
    func getJobs(description: String) -> AnyPublisher<JobsResult, APIError>
    
}

protocol JobsCoordinatorProtocol: AnyObject {

    func showJobDetail(_ job: Job)
    func showThemeSelection()
    func showSettings()

}
