//
//  Job.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

struct Job: Decodable, Equatable {

    let id: String
    let title: String
    let description: String
    let company: String
    let companyLogoPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case company
        case companyLogoPath = "company_logo"
    }
    
}
