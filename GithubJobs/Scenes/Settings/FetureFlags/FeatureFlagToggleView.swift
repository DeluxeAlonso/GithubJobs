//
//  FeatureFlagToggleView.swift
//  GithubJobs
//
//  Created by Alonso on 5/11/24.
//

import SwiftUI

struct FeatureFlagToggleView: View {
//    let viewModel: ViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// swiftlint:disable type_name
struct FeatureFlagToggleView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureFlagToggleView(viewModel: FeatureFlagsViewModel(featureFlagsManager: FeatureFlagsManager.shared))
    }
}
