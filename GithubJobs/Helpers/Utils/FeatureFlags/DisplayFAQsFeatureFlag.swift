//
//  DisplayFAQsFeatureFlag.swift
//  GithubJobs
//
//  Created by Alonso on 5/02/25.
//

import SwiftUI

final class DisplayFAQsFeatureFlag: FeatureFlagProtocol {

    let identifier: String = FeatureFlagIdentifier.displayFAQs.rawValue
    let title: String = "Displays FAQs screen"

    @AppStorage("GithubJobs_DisplayFAQs")
    var value: Bool = false

}
