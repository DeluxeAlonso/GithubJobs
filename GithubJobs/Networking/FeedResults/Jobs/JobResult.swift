//
//  JobResult.swift
//  GithubJobs
//
//  Created by Alonso on 8/03/25.
//

import Foundation

struct JobResult: Decodable, Equatable {

    let id: String
    let title: String
    let description: String
    let company: String
    let companyLogoPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "how_to_apply"
        case company
        case companyLogoPath = "company_logo"
    }

}
