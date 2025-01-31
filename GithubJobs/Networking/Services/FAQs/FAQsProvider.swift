//
//  FAQsProvider.swift
//  GithubJobs
//
//  Created by Alonso on 2/12/24.
//

enum FAQsProvider {
    case getAll
}

extension FAQsProvider: Endpoint {

    var base: String { "https://private-45833-githubjobsapi.apiary-mock.com" }

    var path: String {
        switch self {
        case .getAll:
            return "/faqs"
        }
    }

    var params: [String: Any]? {
        switch self {
        case .getAll:
            return nil
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
