//
//  JobsProtocols.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

protocol JobsViewModelProtocol {

    var viewState: Bindable<JobsViewState> { get }
    var needsPrefetch: Bool { get }

    var jobsCells: [JobCellViewModel] { get }

    func getJobs()
    func job(at index: Int) -> Job

}

protocol JobsCoordinatorProtocol: class {

    func showJobDetail(_ job: Job)

}
