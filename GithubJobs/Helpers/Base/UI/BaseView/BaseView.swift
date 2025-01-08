//
//  BaseView.swift
//  GithubJobs
//
//  Created by Alonso on 26/12/24.
//

import SwiftUI

protocol BaseView: View {
    associatedtype MainContent: View

    associatedtype LoadingContent: View
    associatedtype PopulatedContent: View
    associatedtype ErrorContent: View

    var loading: LoadingContent { get }
    var populated: PopulatedContent { get }
    var error: ErrorContent { get }

    var content: MainContent { get }
}

extension BaseView {
    var loading: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .controlSize(.large)
                .padding(.top, 24.0)
            Spacer()
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
