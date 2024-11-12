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
        VStack {
            ForEach(viewModel.items, id: \.title) {
                FAQsItemContent(viewModel: $0)
            }
        }
    }
}

// swiftlint:disable type_name
struct FAQsContent_Previews: PreviewProvider {
    static var previews: some View {
        FAQsContent(viewModel: FAQsViewModel(items: [.init(title: "Title", subtitles: ["Subtitle"])]))
    }
}
