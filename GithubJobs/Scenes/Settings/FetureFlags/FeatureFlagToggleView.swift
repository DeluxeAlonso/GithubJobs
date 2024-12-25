//
//  FeatureFlagToggleView.swift
//  GithubJobs
//
//  Created by Alonso on 5/11/24.
//

import SwiftUI

struct FeatureFlagToggleView<ViewModel: FeatureFlagToggleViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Toggle(viewModel.title, isOn: $viewModel.value)
            .padding(.vertical, viewModel.verticalPadding)
    }
}

// swiftlint:disable type_name
struct FeatureFlagToggleView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureFlagToggleView(viewModel: FeatureFlagToggleViewModel(CustomChevronFeatureFlag()))
    }
}
