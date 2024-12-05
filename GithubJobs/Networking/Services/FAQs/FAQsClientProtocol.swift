//
//  FAQsClientProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 2/12/24.
//

import Foundation

protocol FAQsClientProtocol {

    func getFAQs() async -> Result<JobsResult, APIError>

}
