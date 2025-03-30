//
//  DisplayFAQsFeatureFlag.swift
//  GithubJobs
//
//  Created by Alonso on 5/02/25.
//

import SwiftUI

final class DisplayFAQsFeatureFlag: MutableFeatureFlagProtocol {

    let identifier: String = FeatureFlagIdentifier.displayFAQs.rawValue
    let title: String = "Displays FAQs screen"

    @AppStorage("GithubJobs_DisplayFAQs")
    private var value: Bool = false

    func setValue(_ value: Bool) {
        self.value = value
    }

}
