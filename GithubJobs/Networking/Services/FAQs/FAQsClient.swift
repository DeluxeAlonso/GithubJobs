//
//  FAQsClient.swift
//  GithubJobs
//
//  Created by Alonso on 1/12/24.
//

import Foundation

final class FAQsClient: FAQsClientProtocol, APIClient {

    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    func getFAQs() async -> Result<FAQsResult, APIError> {
        let request = FAQsProvider.getAll.request
        do {
            let result = try await fetch(with: request, decodingType: FAQsResult.self)
            return .success(result)
        } catch {
            guard let apiError = error as? APIError else { return .failure(.invalidData) }
            return .failure(apiError)
        }
    }

}
