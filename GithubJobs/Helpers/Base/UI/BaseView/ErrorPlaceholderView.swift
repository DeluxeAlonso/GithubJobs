//
//  ErrorPlaceholderView.swift
//  GithubJobs
//
//  Created by Alonso on 11/01/25.
//

import SwiftUI

@MainActor
protocol ErrorPlaceholderView: View {
    associatedtype ErrorContent: View

    var error: ErrorContent { get }
    var errorViewModel: ErrorViewModel? { get }
}

extension ErrorPlaceholderView {
    var error: some View {
        VStack {
            Spacer()
            errorViewModel.flatMap {
                ErrorView(viewModel: $0)
            }
            Spacer()
        }
    }
}
