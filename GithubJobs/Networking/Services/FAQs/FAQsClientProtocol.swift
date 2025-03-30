//
//  FAQsClientProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 2/12/24.
//

protocol FAQsClientProtocol: Sendable {

    func getFAQs() async -> Result<FAQsResult, APIError>

}
