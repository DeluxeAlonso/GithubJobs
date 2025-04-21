//
//  FeatureFlagProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 5/02/25.
//

protocol FeatureFlagProtocol: Sendable {

    var identifier: String { get }
    var title: String { get }
    var value: Bool { get }

}

protocol MutableFeatureFlagProtocol {

    var identifier: String { get }
    var title: String { get }
    var value: Bool { get }

    func setValue(_ value: Bool)

}

final class FeatureFlag: FeatureFlagProtocol {
    let identifier: String
    let title: String
    let value: Bool

    init(_ mutableFeatureFlag: MutableFeatureFlagProtocol) {
        self.identifier = mutableFeatureFlag.identifier
        self.title = mutableFeatureFlag.title
        self.value = mutableFeatureFlag.value
    }
}
