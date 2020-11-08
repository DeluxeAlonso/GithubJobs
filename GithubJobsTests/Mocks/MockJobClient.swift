//
//  MockClient.swift
//  GithubJobsTests
//
//  Created by Alonso on 11/8/20.
//

import Foundation
@testable import GithubJobs

final class MockJobClient: JobClient {

    var getJobResult: Result<JobsResult, APIError>!
    override func getJobs(page: Int, completion: @escaping (Result<JobsResult, APIError>) -> Void) {
        completion(getJobResult)
    }

}
