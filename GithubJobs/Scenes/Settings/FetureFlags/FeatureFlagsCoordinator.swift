//
//  ColorSelectionCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import UIKit
import SwiftUI

final class FeatureFlagsCoordinator: BaseCoordinator {

    var presentingViewController: UIViewController?
    var detailNavigationController: UINavigationController?

    override func start() {
        let hostingConfiguration = HostingConfiguration()

        let viewModel = makeViewModel(hostingConfiguration: hostingConfiguration)
        let view = FeatureFlagsContent(viewModel: viewModel)
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

    private func makeInteractort() -> FeatureFlagsInteractorProtocol {
        FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared)
    }

    private func makeViewModel(hostingConfiguration: HostingConfiguration) -> some FeatureFlagsViewModelProtocol {
        FeatureFlagsViewModel(interactor: makeInteractort(),
                              hostingConfiguration: hostingConfiguration)
    }

}
