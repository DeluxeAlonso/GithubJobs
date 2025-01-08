//
//  FAQsContent.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import SwiftUI

// TODO: - Split BaseView intro protocols for Loading and Error State
struct FAQsContent<ViewModel: FAQsViewModelProtocol>: BaseView {
    @ObservedObject var viewModel: ViewModel

    var errorViewModel: ErrorViewModel? { viewModel.errorViewModel }

    var body: some View {
        content
            .task {
                await viewModel.load()
            }
    }

    @ViewBuilder
    var content: some View {
        switch viewModel.viewState {
        case .loading: loading
        case .populated: populated
        case .error: error
        }
    }

    var populated: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                ForEach(viewModel.items, id: \.title) {
                    FAQsItemContent(viewModel: $0)
                }
                Spacer()
            }
            .padding(.top, 24.0)
        }
    }
}
