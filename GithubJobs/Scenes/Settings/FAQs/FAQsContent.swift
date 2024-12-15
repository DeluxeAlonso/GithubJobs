//
//  FAQsContent.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import SwiftUI

struct FAQsContent<ViewModel: FAQsViewModelProtocol>: View {
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
