//
//  Job+MockInitializer.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import Foundation
@testable import GithubJobs

extension Job {

    static func with(id: String = "1",
                     title: String = "Job 1",
                     description: String = "Description",
                     company: String = "Company",
                     companyLogoPath: String? = "/logo.jpg") -> Job {
        return Job(id: id, title: title,
                   description: description,
                   company: company,
                   companyLogoPath: companyLogoPath)
    }

}
