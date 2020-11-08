//
//  JobClientProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

protocol JobClientProtocol {
    
    func getJobs(page: Int, completion: @escaping (Result<JobsResult, APIError>) -> Void)

    func getJobs(description: String, completion: @escaping (Result<JobsResult, APIError>) -> Void)

    func getJobs(page: Int, description: String, completion: @escaping (Result<JobsResult, APIError>) -> Void)

}
