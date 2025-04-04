//
//  JobsClientProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine

protocol JobsClientProtocol {

    func getJobs(page: Int) -> AnyPublisher<JobsResult, APIError>
    func getJobs(page: Int) async throws -> JobsResult
    func getJobs(description: String) -> AnyPublisher<JobsResult, APIError>
    func getJobs(description: String) async throws -> JobsResult

}
