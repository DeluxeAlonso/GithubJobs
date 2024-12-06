//
//  FAQsInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 30/11/24.
//

import Foundation

protocol FAQsInteractorProtocol {

    func getAllFAQs() async -> Result<FAQsResult, APIError>

}

final class FAQsInteractor: FAQsInteractorProtocol {

    private let faqsClient: FAQsClientProtocol

    init(faqsClient: FAQsClientProtocol) {
        self.faqsClient = faqsClient
    }

    func getAllFAQs() async -> Result<FAQsResult, APIError> {
        await faqsClient.getFAQs()
    }

}
