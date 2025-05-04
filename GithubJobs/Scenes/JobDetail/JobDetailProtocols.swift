//
//  JobDetailProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine
import Coordinator

@MainActor
protocol JobDetailViewModelProtocol {

    var viewStatePublisher: Published<JobDetailViewState>.Publisher { get }

    var jobTitle: String? { get }
    var jobsCells: [JobCellViewModel] { get }

    func getRelatedJobs()
    func job(at index: Int) -> Job

    func makeJobDetailHeaderViewModel() -> JobDetailHeaderViewModelProtocol

}

@MainActor
protocol JobDetailCoordinatorProtocol: Coordinator {

    func showJobDetail(_ job: Job)

}
