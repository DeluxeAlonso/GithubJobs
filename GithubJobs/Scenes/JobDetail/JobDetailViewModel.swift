//
//  JobDetailViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

struct JobDetailViewModel: JobDetailViewModelProtocol {

    private let job: Job
    private let jobClient: JobClientProtocol

    let viewState: Bindable<JobDetailViewState> = Bindable(.initial)

    // MARK: - Computed Properties

    var jobTitle: String? {
        return job.title
    }

    var jobsCells: [JobCellViewModel] {
        let jobs = viewState.value.currentJobs
        return jobs.map { JobCellViewModel($0) }
    }

    // MARK: - Initializers

    init(_ job: Job, jobClient: JobClientProtocol) {
        self.job = job
        self.jobClient = jobClient
    }

    // MARK: - Public

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

    func job(at index: Int) -> Job {
        let jobs = viewState.value.currentJobs
        return jobs[index]
    }

    func makeJobDetailHeaderViewModel() -> JobDetailHeaderViewModelProtocol {
        return JobDetailHeaderViewModel(job)
    }

    // MARK: - Private

    private func processResult(_ jobs: [Job]) -> JobDetailViewState {
        // We only show related jobs that are not the one we are currently displaying.
        let filteredJobs = jobs.filter { $0.id != job.id }
        guard !filteredJobs.isEmpty else { return .empty }
        
        return .populated(filteredJobs)
    }

}
