//
//  FeatureFlagsContent.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

struct FeatureFlagsContent: View {
    @ObservedObject var viewModel: FeatureFlagsViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// swiftlint:disable type_name
struct FeatureFlagsContent_Previews: PreviewProvider {
    static var previews: some View {
        FeatureFlagsContent(viewModel: FeatureFlagsViewModel(colorManager: FeatureFlagsManager.shared))
    }
}
