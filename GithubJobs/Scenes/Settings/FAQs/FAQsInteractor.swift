//
//  FAQsInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 30/11/24.
//

protocol FAQsInteractorProtocol: Sendable {

    func getAllFAQs() async -> Result<[FAQ], APIError>

}

final class FAQsInteractor: FAQsInteractorProtocol {

    private let faqsClient: FAQsClientProtocol

    // MARK: - Initializers

    init(faqsClient: FAQsClientProtocol) {
        self.faqsClient = faqsClient
    }

    // MARK: - FAQsInteractorProtocol

    func getAllFAQs() async -> Result<[FAQ], APIError> {
        switch await faqsClient.getFAQs() {
        case .success(let result):
            return .success(result.faqs.map(FAQ.init))
        case .failure(let error):
            return .failure(error)
        }
    }

}
