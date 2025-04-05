//
//  JobsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

@preconcurrency import Combine

final class JobsViewModel: JobsViewModelProtocol {

    private let interactor: JobsInteractorProtocol

    @Published private var viewState: JobsViewState = .initial

    var viewStatePublisher: Published<JobsViewState>.Publisher {
        $viewState
    }

    // MARK: - Computed Properties

    private var currentJobs: [Job] {
        viewState.currentJobs
    }

    var needsPrefetch: Bool {
        viewState.needsPrefetch
    }

    var jobsCells: [JobCellViewModel] {
        currentJobs.map { JobCellViewModel($0) }
    }

    // MARK: - Initializers

    init(interactor: JobsInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - JobsViewModelProtocol

    func getJobs() {
        fetchJobs(currentPage: viewState.currentPage)
    }

    func refreshJobs() {
        fetchJobs(currentPage: .zero)
    }

    func job(at index: Int) -> Job {
        currentJobs[index]
    }

    // MARK: - Private

    private func fetchJobs(currentPage: Int) {
        Task { @MainActor in
            do {
                let retrievedJobs = try await interactor.getJobs(page: currentPage)
                self.viewState = processResult(retrievedJobs, currentPage: currentPage, currentJobs: self.currentJobs)
            } catch let error as APIError {
                self.viewState = .error(message: error.description)
            }
        }
    }

    private func processResult(_ jobs: [Job],
                               currentPage: Int,
                               currentJobs: [Job]) -> JobsViewState {
        var allJobs = currentPage == 1 ? [] : currentJobs
        allJobs.append(contentsOf: jobs)
        guard !allJobs.isEmpty else { return .empty }

        return jobs.isEmpty ? .populated(allJobs) : .paging(allJobs, next: currentPage + 1)
    }

}
