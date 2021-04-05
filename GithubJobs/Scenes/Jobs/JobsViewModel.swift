//
//  JobsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine

final class JobsViewModel: JobsViewModelProtocol {

    private let jobClient: JobClientProtocol

    private var cancellables: Set<AnyCancellable> = []

    @Published var viewState: JobsViewState = .initial

    var viewStatePublisher: Published<JobsViewState>.Publisher {
        $viewState
    }

    // MARK: - Computed Properties

    private var jobs: [Job] {
        return viewState.currentJobs
    }

    var needsPrefetch: Bool {
        return viewState.needsPrefetch
    }

    var jobsCells: [JobCellViewModel] {
        return jobs.map { JobCellViewModel($0) }
    }

    // MARK: - Initializers

    init(jobClient: JobClientProtocol) {
        self.jobClient = jobClient
    }

    // MARK: - Public

    func getJobs() {
        fetchJobs(currentPage: viewState.currentPage)
    }

    func job(at index: Int) -> Job {
        return jobs[index]
    }

    // MARK: - Private

    private func fetchJobs(currentPage: Int) {
        jobClient.getJobs(page: currentPage)
            .sink { completion in
                if case let .failure(error) = completion { self.viewState = .error(error) }
            } receiveValue: { jobResult in
                self.viewState = self.processResult(jobResult.jobs, currentPage: currentPage, currentJobs: self.jobs)
            }.store(in: &cancellables)
    }

    private func processResult(_ jobs: [Job], currentPage: Int,
                               currentJobs: [Job]) -> JobsViewState {
        var allJobs = currentPage == 1 ? [] : currentJobs
        allJobs.append(contentsOf: jobs)
        guard !allJobs.isEmpty else { return .empty }

        return jobs.isEmpty ? .populated(allJobs) : .paging(allJobs, next: currentPage + 1)
    }

}
