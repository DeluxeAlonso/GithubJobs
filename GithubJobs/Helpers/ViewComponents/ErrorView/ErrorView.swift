//
//  ErrorView.swift
//  GithubJobs
//
//  Created by Alonso on 15/11/24.
//

import SwiftUI

struct ErrorView: View {
    let viewModel: ErrorViewModelProtocol

    var body: some View {
        VStack(spacing: 16.0) {
            icon
            VStack(spacing: 8.0) {
                title
                subtitles
            }
        }
    }

    private var icon: some View {
        Image("errorIcon")
            .resizable()
            .scaledToFit()
            .frame(width: viewModel.imageSize.width, height: viewModel.imageSize.height)
    }

    private var title: some View {
        viewModel.title.flatMap {
            Text($0)
                .font(.headline)
        }
    }

    private var subtitles: some View {
        ForEach(viewModel.subtitles, id: \.self) {
            Text($0)
                .font(.subheadline)
        }
    }
}

// swiftlint:disable type_name
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ErrorViewModel(title: "Title", subtitles: ["Subtitle1", "Subtitle 2"])
        return ErrorView(viewModel: viewModel)
    }
}
