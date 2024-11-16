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
        VStack {
            viewModel.title.flatMap {
                Text($0)
            }
            ForEach(viewModel.subtitles, id: \.self) {
                Text($0)
            }

        }
    }
}

// swiftlint:disable type_name
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ErrorViewModel(title: "Title", subtitles: ["Subtitles"])
        return ErrorView(viewModel: viewModel)
    }
}
