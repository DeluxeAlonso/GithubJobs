//
//  FAQsItemViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 25/01/25.
//

import Foundation

protocol FAQsItemViewModelProtocol: ObservableObject {

    var title: String { get }
    var subtitles: [String] { get }
    var expanded: Bool { get set }
    var expandCollapseStyleConfiguration: ExpandCollapseControlStyleConfiguration { get }
    var padding: CGFloat { get }
    var subtitlesVerticalSpacing: CGFloat { get }

}

final class FAQsItemViewModel: FAQsItemViewModelProtocol {

    let title: String
    let subtitles: [String]
    @Published var expanded: Bool = false

    var expandCollapseStyleConfiguration: ExpandCollapseControlStyleConfiguration {
        ExpandCollapseControlStyleConfiguration(expandedIconName: "minus",
                                                collapsedIconName: "plus",
                                                iconSize: CGSize(width: 16.0, height: 16.0),
                                                iconTrailingPadding: 16.0,
                                                verticalSpacing: 8.0,
                                                horizontalSpacing: 8.0)
    }

    var padding: CGFloat { 16.0 }

    var subtitlesVerticalSpacing: CGFloat { 8.0 }

    init(title: String,
         subtitles: [String],
         expanded: Bool = false) {
        self.title = title
        self.subtitles = subtitles
        self.expanded = expanded
    }

    init(faq: FAQ) {
        self.title = faq.title
        self.subtitles = faq.descriptions
        self.expanded = false
    }
}
