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
        let faqsClient = FAQsClient()
        let interactor = FAQsInteractor(faqsClient: faqsClient)
        let viewModel = FAQsViewModel(interactor: interactor)
        let view = FAQsContent(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        // TODO: - This should be updated from view model if possible
        viewController.title = "FAQs"

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
