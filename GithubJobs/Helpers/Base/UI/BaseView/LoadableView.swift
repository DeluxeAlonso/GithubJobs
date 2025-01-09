//
//  LoadableView.swift
//  GithubJobs
//
//  Created by Alonso on 9/01/25.
//

import SwiftUI

protocol LoadableView: View {

    associatedtype LoadingContent: View

    var loading: LoadingContent { get }

}

extension LoadableView {
    var loading: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .controlSize(.large)
                .padding(.top, 24.0)
            Spacer()
        }
    }
}
