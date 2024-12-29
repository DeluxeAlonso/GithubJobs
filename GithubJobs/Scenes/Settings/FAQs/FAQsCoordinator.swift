//
//  FAQsCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 14/11/24.
//

import UIKit
import SwiftUI

final class FAQsCoordinator: BaseCoordinator {

    var presentingViewController: UIViewController?
    var detailNavigationController: UINavigationController?

    override func start() {
        let hostingConfiguration = HostingConfiguration()

        let faqsClient = FAQsClient()
        let interactor = FAQsInteractor(faqsClient: faqsClient)
        let viewModel = FAQsViewModel(interactor: interactor, hostingConfiguration: hostingConfiguration)
        let view = FAQsContent(viewModel: viewModel)
        let viewController = HostingController(rootView: view, configuration: hostingConfiguration)

        if let detailNavigationController = detailNavigationController {
            detailNavigationController.pushViewController(viewController, animated: false)
            navigationController.showDetailViewController(detailNavigationController, sender: nil)
        } else {
            detailNavigationController = navigationController
            navigationController.pushViewController(viewController, animated: true)
        }
        if navigationController.delegate == nil {
            navigationController.delegate = self
        }
    }

    func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
