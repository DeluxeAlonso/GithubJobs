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
