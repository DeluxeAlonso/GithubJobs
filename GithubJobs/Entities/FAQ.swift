//
//  FAQ.swift
//  GithubJobs
//
//  Created by Alonso on 2/12/24.
//

import Foundation

struct FAQ: Decodable, Equatable {

    let id: String
    let title: String
    let descriptions: [String]

}
