//
//  JobsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

protocol JobsViewModelProtocol {

    func getAllJobs()

}

final class JobsViewModel: JobsViewModelProtocol {

    private let jobClient: JobClientProtocol

    init(jobClient: JobClientProtocol) {
        self.jobClient = jobClient
    }

    func getAllJobs() {
        jobClient.getJobs(page: 1) { result in
            switch result {
            case .success(let jobResult):
                print(jobResult)
            case .failure(let error):
                break
            }
        }
    }

}
