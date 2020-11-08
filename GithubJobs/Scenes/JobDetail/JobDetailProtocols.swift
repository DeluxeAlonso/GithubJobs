//
//  JobDetailProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

protocol JobDetailViewModelProtocol {

    var viewState: Bindable<JobDetailViewState> { get }

    var jobTitle: String? { get }
    var jobsCells: [JobCellViewModel] { get }

    func getRelatedJobs()
    func job(at index: Int) -> Job
    func makeJobDetailHeaderViewModel() -> JobDetailHeaderViewModelProtocol

}

protocol JobDetailCoordinatorProtocol: class {

    func showJobDetail(_ job: Job)

}
