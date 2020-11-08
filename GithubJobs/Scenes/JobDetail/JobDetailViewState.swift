//
//  JobDetailViewState.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

enum JobDetailViewState: Equatable {

    case initial
    case empty
    case populated([Job])
    case error(ErrorDescriptable)

    static func == (lhs: JobDetailViewState, rhs: JobDetailViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
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

    var currentJobs: [Job] {
        switch self {
        case .populated(let movies):
            return movies
        case .empty, .error, .initial:
            return []
        }
    }

}
