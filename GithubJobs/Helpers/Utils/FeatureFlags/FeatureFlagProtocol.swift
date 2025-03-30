//
//  FeatureFlagProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 5/02/25.
//

protocol FeatureFlagProtocol {

    var identifier: String { get }
    var title: String { get }
    var value: Bool { get }

}

protocol MutableFeatureFlagProtocol {

    var identifier: String { get }
    var title: String { get }

    func setValue(_ value: Bool)

}
