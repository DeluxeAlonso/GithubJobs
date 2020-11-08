//
//  JobsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

final class JobsViewModel: JobsViewModelProtocol {

    private let jobClient: JobClientProtocol

    let viewState: Bindable<JobsViewState> = Bindable(.initial)

    // MARK: - Computed Properties

    private var jobs: [Job] {
        return viewState.value.currentJobs
    }

    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
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
        fetchJobs(currentPage: viewState.value.currentPage)
    }

    func job(at index: Int) -> Job {
        return jobs[index]
    }

    // MARK: - Private

    private func fetchJobs(currentPage: Int) {
        jobClient.getJobs(page: currentPage) { result in
            switch result {
            case .success(let jobResult):
                self.viewState.value = self.processResult(jobResult.jobs,
                                                          currentPage: currentPage,
                                                          currentJobs: self.jobs)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }

    private func processResult(_ jobs: [Job], currentPage: Int,
                               currentJobs: [Job]) -> JobsViewState {
        var allJobs = currentPage == 1 ? [] : currentJobs
        allJobs.append(contentsOf: jobs)
        guard !allJobs.isEmpty else { return .empty }

        return jobs.isEmpty ? .populated(allJobs) : .paging(allJobs, next: currentPage + 1)
    }

}
