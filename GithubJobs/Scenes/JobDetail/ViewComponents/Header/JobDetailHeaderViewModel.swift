//
//  JobDetailHeaderViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/8/20.
//

protocol JobDetailHeaderViewModelProtocol {

    var jobDescription: String { get }
    var companyLogoURLString: String? { get }

}

struct JobDetailHeaderViewModel: JobDetailHeaderViewModelProtocol {

    let jobDescription: String
    let companyLogoURLString: String?

    init(_ job: Job) {
        self.jobDescription = job.description.htmlToString
        self.companyLogoURLString = job.companyLogoPath
    }

}
