//
//  JobClientProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine

protocol JobClientProtocol {

    func getJobs(page: Int) -> AnyPublisher<JobsResult, APIError>
    func getJobs(description: String) -> AnyPublisher<JobsResult, APIError>

}
