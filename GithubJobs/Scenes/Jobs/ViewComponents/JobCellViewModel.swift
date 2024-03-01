//
//  JobCellViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

protocol JobCellViewModelProtocol {

    var title: String { get }
    var company: String { get }

}

final class JobCellViewModel: JobCellViewModelProtocol {

    let title: String
    let company: String

    init(_ job: Job) {
        self.title = job.title
        self.company = job.company
    }

}
