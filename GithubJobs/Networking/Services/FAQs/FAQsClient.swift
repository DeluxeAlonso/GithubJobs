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

    func getFAQs() async -> Result<JobsResult, APIError> {

    }

}
