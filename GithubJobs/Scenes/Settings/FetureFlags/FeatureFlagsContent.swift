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
        content
            .task {
                await viewModel.load()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .loading: loading
        case .populated: populated
        case .error: error
        }
    }

    private var loading: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Spacer()
        }
    }

    private var populated: some View {
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
    static var populatedViewModel: FeatureFlagsViewModel {
        let viewModel = FeatureFlagsViewModel(interactor: FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared))
        viewModel.viewState = .populated
        return viewModel
    }

    static var previews: some View {
        FeatureFlagsContent(viewModel: populatedViewModel)
            .previewDisplayName("Populated")
    }
}
