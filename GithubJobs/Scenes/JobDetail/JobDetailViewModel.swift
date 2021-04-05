//
//  JobDetailViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine

final class JobDetailViewModel: JobDetailViewModelProtocol {

    private let job: Job
    private let jobClient: JobClientProtocol

    private var cancellables: Set<AnyCancellable> = []

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

    init(_ job: Job, jobClient: JobClientProtocol) {
        self.job = job
        self.jobClient = jobClient
    }

    // MARK: - Public

    func getRelatedJobs() {
        jobClient.getJobs(description: job.title)
            .sink { completion in
                if case let .failure(error) = completion { self.viewState = .error(error) }
            } receiveValue: { jobResult in
                self.viewState = self.processResult(jobResult.jobs)
            }.store(in: &cancellables)
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
