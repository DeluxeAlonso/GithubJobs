//
//  JobDetailViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine

final class JobDetailViewModel: JobDetailViewModelProtocol {

    private let job: Job
    private let interactor: JobsInteractorProtocol

    @Published var viewState: JobDetailViewState = .initial

    var viewStatePublisher: Published<JobDetailViewState>.Publisher {
        $viewState
    }

    // MARK: - Computed Properties

    var jobTitle: String? {
        return job.title
    }

    var jobsCells: [JobCellViewModel] {
        let jobs = viewState.currentJobs
        return jobs.map { JobCellViewModel($0) }
    }

    // MARK: - Initializers

    init(_ job: Job, interactor: JobsInteractorProtocol) {
        self.job = job
        self.interactor = interactor
    }

    // MARK: - JobDetailViewModelProtocol

    func getRelatedJobs() {
        interactor.getJobs(description: job.title)
            .map { $0.jobs }
            .map(processResult)
            .catch { Just(.error(message: $0.description)) }
            .assign(to: &$viewState)
    }

    func job(at index: Int) -> Job {
        let jobs = viewState.currentJobs
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
