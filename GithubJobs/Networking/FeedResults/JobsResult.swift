//
//  JobsResult.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

struct JobsResult: Decodable {

    let jobs: [Job]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.jobs = try container.decode([Job].self)
    }

}
