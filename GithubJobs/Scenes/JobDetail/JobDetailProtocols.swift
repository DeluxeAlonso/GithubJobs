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
    var jobDescription: String? { get }
    var companyLogoURLString: String? { get }
    
    var jobsCells: [JobCellViewModel] { get }

    func job(at index: Int) -> Job
    func getRelatedJobs()

}

protocol JobDetailCoordinatorProtocol: class {

    func showJobDetail(_ job: Job)

}
