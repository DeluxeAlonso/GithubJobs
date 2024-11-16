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
        root
            .task {
                await viewModel.load()
            }
    }

    @ViewBuilder
    private var root: some View {
        switch viewModel.viewState {
        case .loading:
            content
        case .populated:
            content
        case .error:
            error
        }
    }

    private var content: some View {
        VStack {
            ForEach(viewModel.toggles, id: \.identifier) {
                FeatureFlagToggleView(viewModel: $0)
                    .padding()
            }
            Spacer()
        }
    }

    private var error: some View {
        VStack {
            Spacer()
            viewModel.errorViewModel.flatMap {
                ErrorView(viewModel: $0)
            }
            Spacer()
        }
    }
}

// swiftlint:disable type_name
struct FeatureFlagsContent_Previews: PreviewProvider {
    static var previews: some View {
        FeatureFlagsContent(viewModel: FeatureFlagsViewModel(interactor: FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared)))
    }
}
