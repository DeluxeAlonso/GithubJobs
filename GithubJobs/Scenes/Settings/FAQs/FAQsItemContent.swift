//
//  FAQsItemContent.swift
//  GithubJobs
//
//  Created by Alonso on 11/11/24.
//

import SwiftUI

struct FAQsItemContent<ViewModel: FAQsItemViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            ExpandCollapseControlContent(isExpanded: $viewModel.expanded, collapsedContent: {
                Text(viewModel.title)
            }, expandedContent: {
                ForEach(viewModel.subtitles, id: \.self) {
                    Text($0)
                }
            }, configuration: .init())
        }
    }
}

// swiftlint:disable type_name
struct FAQsItemContent_Previews: PreviewProvider {
    static var previews: some View {
        FAQsItemContent(viewModel: FAQsItemViewModel(title: "Title", subtitles: ["Subtitle"]))
    }
}
