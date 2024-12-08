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

    func load() async

}

final class FAQsViewModel: FAQsViewModelProtocol {

    private let interactor: FAQsInteractorProtocol

    @Published var items: [FAQsItemViewModel] = []

    init(interactor: FAQsInteractorProtocol) {
        self.interactor = interactor
    }

    func load() async {
        
    }
}

// MARK: - Items

protocol FAQsItemViewModelProtocol: ObservableObject {

    var title: String { get }
    var subtitles: [String] { get }
    var expanded: Bool { get set }
    var expandCollapseStyleConfiguration: ExpandCollapseControlStyleConfiguration { get }

}

final class FAQsItemViewModel: FAQsItemViewModelProtocol {

    let title: String
    let subtitles: [String]
    @Published var expanded: Bool = false

    var expandCollapseStyleConfiguration: ExpandCollapseControlStyleConfiguration {
        ExpandCollapseControlStyleConfiguration(expandedIconName: "plus", collapsedIconName: "minus")
    }

    init(title: String,
         subtitles: [String],
         expanded: Bool = false) {
        self.title = title
        self.subtitles = subtitles
        self.expanded = expanded
    }
}
