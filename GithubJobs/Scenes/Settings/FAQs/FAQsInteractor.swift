//
//  FAQsInteractor.swift
//  GithubJobs
//
//  Created by Alonso on 30/11/24.
//

import Foundation

protocol FAQsInteractorProtocol {

    func getAllFlags() async -> [FeatureFlagProtocol]

}

final class FAQsInteractor: FAQsInteractorProtocol {

    func getAllFlags() async -> [FeatureFlagProtocol] {

    }

}
