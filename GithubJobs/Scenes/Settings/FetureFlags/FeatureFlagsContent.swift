//
//  FeatureFlagsContent.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

struct FeatureFlagsContent<ViewModel: FeatureFlagsViewModelProtocol>: BaseView {
    @ObservedObject var viewModel: ViewModel

    // MARK: - View

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

    private var populated: some View {
        List {
            ForEach(viewModel.toggles, id: \.identifier) {
                FeatureFlagToggleView(viewModel: $0)
            }
        }
    }

    // MARK: - ErrorPlaceholderView

    var errorViewModel: ErrorViewModel? { viewModel.errorViewModel }
}

struct FeatureFlagsContentPreviews: PreviewProvider {
    static var loadingViewModel: FeatureFlagsViewModel {
        let viewModel = FeatureFlagsViewModel(interactor: FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared),
                                              hostingConfiguration: HostingConfiguration())
        viewModel.viewState = .loading
        return viewModel
    }

    static var populatedViewModel: FeatureFlagsViewModel {
        let viewModel = FeatureFlagsViewModel(interactor: FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared),
                                              hostingConfiguration: HostingConfiguration())
        viewModel.toggles = [FeatureFlagToggleViewModel(MutableCustomChevronFeatureFlag())]
        viewModel.viewState = .populated
        return viewModel
    }

    static var errorViewModel: FeatureFlagsViewModel {
        let viewModel = FeatureFlagsViewModel(interactor: FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared),
                                              hostingConfiguration: HostingConfiguration())
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
