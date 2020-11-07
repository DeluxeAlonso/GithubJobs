//
//  JobProvider.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

enum JobProvider {
    case getAll(page: Int)
}

extension JobProvider: Endpoint {

    var base: String {
        return "https://jobs.github.com"
    }

    var path: String {
        switch self {
        case .getAll:
            return "/positions.json?"
        }
    }

    var params: [String: Any]? {
        switch self {
        case .getAll(let page):
            return ["page": page]
        }
    }

    var parameterEncoding: ParameterEnconding {
        switch self {
        case .getAll:
            return .defaultEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getAll:
            return .get
        }
    }

    var headers: [String : String]? {
        return nil
    }

}
