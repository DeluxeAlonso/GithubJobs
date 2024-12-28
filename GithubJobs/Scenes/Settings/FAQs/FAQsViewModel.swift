//
//  FAQsViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import Combine
import Foundation

@MainActor
protocol FAQsViewModelProtocol: ObservableObject {

    var items: [FAQsItemViewModel] { get }
    var errorViewModel: ErrorViewModel? { get }

    var viewState: FAQsViewState { get }

    func load() async

}

final class FAQsViewModel: FAQsViewModelProtocol {

    private let interactor: FAQsInteractorProtocol

    @Published var items: [FAQsItemViewModel] = []
    @Published var errorViewModel: ErrorViewModel?

    @Published var viewState: FAQsViewState = .loading

    init(interactor: FAQsInteractorProtocol) {
        self.interactor = interactor
    }

    func load() async {
        viewState = .loading
        switch await interactor.getAllFAQs() {
        case .success(let faqs):
            self.items = faqs.map { FAQsItemViewModel(faq: $0) }
            self.viewState = .populated
        case .failure(let error):
            self.errorViewModel = ErrorViewModel(localizedError: error)
            self.viewState = .error
        }
    }
}

// MARK: - Items

protocol FAQsItemViewModelProtocol: ObservableObject {

    var title: String { get }
    var subtitles: [String] { get }
    var expanded: Bool { get set }
    var expandCollapseStyleConfiguration: ExpandCollapseControlStyleConfiguration { get }
    var padding: CGFloat { get }

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
                                                horizontalSpacing: 8.0)
    }

    var padding: CGFloat { 16.0 }

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
