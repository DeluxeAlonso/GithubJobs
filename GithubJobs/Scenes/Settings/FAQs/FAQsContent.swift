//
//  FAQsContent.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import SwiftUI

struct FAQsContent<ViewModel: FAQsViewModelProtocol>: BaseView {
    @ObservedObject var viewModel: ViewModel

    // MARK: - View

    var body: some View {
        content
            .task {
                await viewModel.load()
            }
    }

    // MARK: - Private

    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
        case .loading: loading
        case .populated: populated
        case .error: error
        }
    }

    private var populated: some View {
        ScrollView {
            VStack(spacing: viewModel.verticalSpacing) {
                ForEach(viewModel.items, id: \.title) {
                    FAQsItemContent(viewModel: $0)
                }
                Spacer()
            }
            .padding(.top, viewModel.topPadding)
        }
    }

    // MARK: - ErrorPlaceHolderView

    var errorViewModel: ErrorViewModel? { viewModel.errorViewModel }
}
