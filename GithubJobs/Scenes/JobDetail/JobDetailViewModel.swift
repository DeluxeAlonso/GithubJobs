//
//  JobDetailViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

struct JobDetailViewModel: JobDetailViewModelProtocol {

    private let jobClient: JobClientProtocol

    let viewState: Bindable<JobDetailViewState> = Bindable(.initial)

    var job: Job!

    // MARK: - Computed Properties

    var jobTitle: String? {
        return job.title
    }

    var jobDescription: String? {
        return job.description
    }

    private var jobs: [Job] {
        return viewState.value.currentJobs
    }

    var jobsCells: [JobCellViewModel] {
        return jobs.map { JobCellViewModel($0) }
    }

    // MARK: - Initializers

    init(jobClient: JobClientProtocol) {
        self.jobClient = jobClient
    }

    // MARK: - Public

    func job(at index: Int) -> Job {
        return jobs[index]
    }

    func getRelatedJobs() {
        jobClient.getJobs(description: job.title) { result in
            switch result {
            case .success(let jobResult):
                self.viewState.value = self.processResult(jobResult.jobs)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }

    // MARK: - Private

    private func processResult(_ jobs: [Job]) -> JobDetailViewState {
        guard !jobs.isEmpty else { return .empty }

        // We only show related jobs that are not the one we are currently displaying.
        return .populated(jobs.filter { $0.id != job.id })
    }

}
