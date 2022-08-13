//
//  JobsViewState.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

enum JobsViewState: Equatable {

    case initial
    case empty
    case paging([Job], next: Int)
    case populated([Job])
    case error(message: String)

    static func == (lhs: JobsViewState, rhs: JobsViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (let .paging(lhsEntities, _), let .paging(rhsEntities, _)):
            return lhsEntities == rhsEntities
        case (let .populated(lhsEntities), let .populated(rhsEntities)):
            return lhsEntities == rhsEntities
        case (.empty, .empty):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }

    var currentPage: Int {
        switch self {
        case .initial, .populated, .empty, .error:
            return 1
        case .paging(_, let page):
            return page
        }
    }

    var currentJobs: [Job] {
        switch self {
        case .populated(let jobs):
            return jobs
        case .paging(let jobs, _):
            return jobs
        case .empty, .error, .initial:
            return []
        }
    }

    var needsPrefetch: Bool {
        switch self {
        case .initial, .populated, .empty, .error:
            return false
        case .paging:
            return true
        }
    }

}
