//
//  MockFAQsInteractor.swift
//  GithubJobsTests
//
//  Created by Alonso on 20/01/25.
//

@testable import GithubJobs

final class MockFAQsInteractor: @unchecked Sendable, FAQsInteractorProtocol {

    var getAllFAQsResult: Result<[FAQ], APIError> = .success([])
    private(set) var getAllFAQsCallCount = 0
    func getAllFAQs() async -> Result<[FAQ], APIError> {
        getAllFAQsCallCount += 1
        return getAllFAQsResult
    }

}
