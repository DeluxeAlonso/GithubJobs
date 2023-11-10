//
//  JobProvider.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

enum JobProvider {
    case getAll(page: Int, description: String)
}

extension JobProvider: Endpoint {

    var base: String { "https://private-45833-githubjobsapi.apiary-mock.com" }

    var path: String {
        switch self {
        case .getAll:
            return "/positions"
        }
    }

    var params: [String: Any]? {
        switch self {
        case .getAll(let page, let description):
            return ["page": page, "description": description]
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

    var headers: [String: String]? {
        nil
    }

}
