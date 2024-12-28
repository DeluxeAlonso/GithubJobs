//
//  FAQsContent.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import SwiftUI

struct FAQsContent<ViewModel: FAQsViewModelProtocol>: BaseView {
    @ObservedObject var viewModel: ViewModel

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

    var loading: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .controlSize(.large)
                .padding(.top, 24.0)
            Spacer()
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
