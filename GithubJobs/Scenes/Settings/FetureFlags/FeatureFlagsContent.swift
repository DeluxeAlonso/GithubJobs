//
//  FeatureFlagsContent.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

struct FeatureFlagsContent<ViewModel: FeatureFlagsViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            ForEach(viewModel.toggles, id: \.identifier) {
                FeatureFlagToggleView(viewModel: $0)
            }
        }
    }
}

// swiftlint:disable type_name
struct FeatureFlagsContent_Previews: PreviewProvider {
    static var previews: some View {
        FeatureFlagsContent(viewModel: FeatureFlagsViewModel(featureFlagsManager: FeatureFlagsManager.shared))
    }
}
