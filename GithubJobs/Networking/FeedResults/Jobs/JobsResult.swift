//
//  JobsResult.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

struct JobsResult: Decodable {

    let jobs: [JobResult]

    init(jobs: [JobResult]) {
        self.jobs = jobs
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.jobs = try container.decode([JobResult].self)
    }

}
