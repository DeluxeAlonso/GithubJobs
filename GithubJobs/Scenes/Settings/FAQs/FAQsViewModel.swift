//
//  FAQsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import Combine

@MainActor
protocol FAQsViewModelProtocol: ObservableObject {

    var items: [FAQsItemViewModel] { get }

}

final class FAQsViewModel: FAQsViewModelProtocol {
    @Published var items: [FAQsItemViewModel]

    init(items: [FAQsItemViewModel]) {
        self.items = items
    }
}

// MARK: - Items

protocol FAQsItemViewModelProtocol: ObservableObject {

    var title: String { get }
    var subtitles: [String] { get }
    var expanded: Bool { get set }
    var expandCollapseConfiguration: ExpandCollapseControlConfiguration { get }

}

final class FAQsItemViewModel: FAQsItemViewModelProtocol {

    let title: String
    let subtitles: [String]
    @Published var expanded: Bool = false

    var expandCollapseConfiguration: ExpandCollapseControlConfiguration {
        ExpandCollapseControlConfiguration(expandedIconName: "plus", collapsedIconName: "minus")
    }

    init(title: String,
         subtitles: [String],
         expanded: Bool = false) {
        self.title = title
        self.subtitles = subtitles
        self.expanded = expanded
    }
}
