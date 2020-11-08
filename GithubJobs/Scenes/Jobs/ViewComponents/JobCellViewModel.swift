//
//  JobCellViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

protocol JobCellViewModelProtocol {

    var title: String { get }
    var company: String { get }

}

class JobCellViewModel: JobCellViewModelProtocol {

    var title: String
    var company: String

    init(_ job: Job) {
        self.title = job.title
        self.company = job.company
    }

}
