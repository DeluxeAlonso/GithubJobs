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

protocol JobsCoordinatorProtocol: AnyObject {

    func showJobDetail(_ job: Job)

}
