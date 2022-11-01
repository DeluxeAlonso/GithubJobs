//
//  JobsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Combine

final class JobsViewModel: JobsViewModelProtocol {

    private let interactor: JobsInteractorProtocol

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

    init(interactor: JobsInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - JobsViewModelProtocol

    func getJobs() {
        fetchJobs(currentPage: viewState.currentPage)
    }

    func job(at index: Int) -> Job {
        return jobs[index]
    }

    // MARK: - Private

    private func fetchJobs(currentPage: Int) {
        interactor.getJobs(page: currentPage)
            .map { jobResult -> JobsViewState in
                return self.processResult(jobResult.jobs, currentPage: currentPage, currentJobs: self.jobs)
            }.catch { error -> Just<JobsViewState> in
                return Just(.error(message: error.description))
            }.assign(to: &$viewState)
    }

    private func processResult(_ jobs: [Job], currentPage: Int,
                               currentJobs: [Job]) -> JobsViewState {
        var allJobs = currentPage == 1 ? [] : currentJobs
        allJobs.append(contentsOf: jobs)
        guard !allJobs.isEmpty else { return .empty }

        return jobs.isEmpty ? .populated(allJobs) : .paging(allJobs, next: currentPage + 1)
    }

}
