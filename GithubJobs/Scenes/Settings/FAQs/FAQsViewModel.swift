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

    var verticalSpacing: CGFloat { get }
    var topPadding: CGFloat { get }

}

final class FAQsViewModel: FAQsViewModelProtocol {

    private let interactor: FAQsInteractorProtocol

    @Published var items: [FAQsItemViewModel] = []
    @Published var errorViewModel: ErrorViewModel?

    @Published var viewState: FAQsViewState = .loading

    private weak var hostingConfiguration: HostingConfiguration?

    var verticalSpacing: CGFloat { 16.0 }

    var topPadding: CGFloat { 24.0 }

    // MARK: - Initializers

    init(interactor: FAQsInteractorProtocol,
         hostingConfiguration: HostingConfiguration) {
        self.interactor = interactor
        self.hostingConfiguration = hostingConfiguration
        self.hostingConfiguration?.title = LocalizedStrings.faqsTitle()
    }

    // MARK: - FAQsViewModelProtocol

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
