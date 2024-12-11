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
        ExpandCollapseControlContent(isExpanded: $viewModel.expanded, collapsedContent: {
            Text(viewModel.title)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 16.0)
        }, expandedContent: {
            ForEach(viewModel.subtitles, id: \.self) {
                Text($0)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 16.0)
            }
        }, styleConfiguration: viewModel.expandCollapseStyleConfiguration)
    }
}

// swiftlint:disable type_name
struct FAQsItemContent_Previews: PreviewProvider {
    static var previews: some View {
        FAQsItemContent(viewModel: FAQsItemViewModel(title: "Title", subtitles: ["Subtitle"]))
    }
}
