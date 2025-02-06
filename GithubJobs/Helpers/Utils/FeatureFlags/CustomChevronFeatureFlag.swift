//
//  CustomChevronFeatureFlag.swift
//  GithubJobs
//
//  Created by Alonso on 5/02/25.
//

import SwiftUI

final class CustomChevronFeatureFlag: FeatureFlagProtocol {

    let identifier: String = FeatureFlagIdentifier.customChevron.rawValue
    let title: String = "User custom chevron view"

    @AppStorage("GithubJobs_UseCustomChevron")
    var value: Bool = false

}
