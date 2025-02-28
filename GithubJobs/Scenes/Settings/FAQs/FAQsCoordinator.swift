//
//  FAQsCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 14/11/24.
//

import UIKit
import SwiftUI

final class FAQsCoordinator: BaseCoordinator {

    override func build() -> UIViewController {
        let hostingConfiguration = HostingConfiguration()

        let viewModel = makeViewModel(hostingConfiguration: hostingConfiguration)
        let view = FAQsContent(viewModel: viewModel)
        return HostingController(rootView: view, configuration: hostingConfiguration)
    }

    // MARK: - Builders

    private func makeInteractor() -> FAQsInteractorProtocol {
        let faqsClient = FAQsClient()
        return FAQsInteractor(faqsClient: faqsClient)
    }

    private func makeViewModel(hostingConfiguration: HostingConfiguration) -> some FAQsViewModelProtocol {
        FAQsViewModel(interactor: makeInteractor(),
                      hostingConfiguration: hostingConfiguration)
    }

}
