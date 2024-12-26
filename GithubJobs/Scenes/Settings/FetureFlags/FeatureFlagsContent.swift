//
//  FeatureFlagsContent.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

struct FeatureFlagsContent<ViewModel: FeatureFlagsViewModelProtocol>: BaseView {
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

    var loading: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
            Spacer()
        }
    }

    var populated: some View {
        List {
            ForEach(viewModel.toggles, id: \.identifier) {
                FeatureFlagToggleView(viewModel: $0)
            }
        }
    }

    var error: some View {
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

    static var loadingViewModel: FeatureFlagsViewModel {
        let viewModel = FeatureFlagsViewModel(interactor: FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared))
        viewModel.viewState = .loading
        return viewModel
    }

    static var populatedViewModel: FeatureFlagsViewModel {
        let viewModel = FeatureFlagsViewModel(interactor: FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared))
        viewModel.toggles = [FeatureFlagToggleViewModel(CustomChevronFeatureFlag())]
        viewModel.viewState = .populated
        return viewModel
    }

    static var errorViewModel: FeatureFlagsViewModel {
        let viewModel = FeatureFlagsViewModel(interactor: FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared))
        viewModel.errorViewModel = ErrorViewModel(title: "Error", subtitles: ["Error Subtitle"])
        viewModel.viewState = .error
        return viewModel
    }

    static var previews: some View {
        FeatureFlagsContent(viewModel: populatedViewModel)
            .previewDisplayName("Populated")

        FeatureFlagsContent(viewModel: loadingViewModel)
            .previewDisplayName("Loading")

        FeatureFlagsContent(viewModel: errorViewModel)
            .previewDisplayName("Error")
    }
}
