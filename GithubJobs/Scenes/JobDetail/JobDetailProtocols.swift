//
//  JobDetailProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine

protocol JobDetailViewModelProtocol {

    var viewStatePublisher: Published<JobDetailViewState>.Publisher { get }

    var jobTitle: String? { get }
    var jobsCells: [JobCellViewModel] { get }

    func getRelatedJobs()
    func job(at index: Int) -> Job
    func makeJobDetailHeaderViewModel() -> JobDetailHeaderViewModelProtocol

}

protocol JobDetailCoordinatorProtocol: class {

    func showJobDetail(_ job: Job)

}
