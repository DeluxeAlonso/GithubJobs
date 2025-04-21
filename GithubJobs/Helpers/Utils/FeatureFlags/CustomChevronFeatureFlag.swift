//
//  CustomChevronFeatureFlag.swift
//  GithubJobs
//
//  Created by Alonso on 5/02/25.
//

import SwiftUI

final class CustomChevronFeatureFlag: MutableFeatureFlagProtocol {

    let identifier: String = FeatureFlagIdentifier.customChevron.rawValue
    let title: String = "User custom chevron view"

    @AppStorage("GithubJobs_UseCustomChevron")
    private(set) var value: Bool = false

    func setValue(_ value: Bool) {
        self.value = value
    }

}
