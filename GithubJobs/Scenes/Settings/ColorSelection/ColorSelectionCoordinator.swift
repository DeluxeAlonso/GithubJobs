//
//  ColorSelectionCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import UIKit
import SwiftUI

final class ColorSelectionCoordinator: BaseCoordinator {

    var presentingViewController: UIViewController?
    var detailNavigationController: UINavigationController?

    override func start() {
        let colorManager = ColorManager.shared
        let viewModel = ColorSelectionViewModel(colorManager: colorManager)
        let view = ColorSelectionContent(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)

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

    // MARK: - ThemeSelectionCoordinatorProtocol

    func startModally() {
        let colorManager = ColorManager.shared
        let viewModel = ColorSelectionViewModel(colorManager: colorManager)
        let view = ColorSelectionContent(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)

        navigationController.pushViewController(viewController, animated: false)
        navigationController.modalPresentationStyle = .fullScreen

        presentingViewController?.present(navigationController, animated: true, completion: nil)
    }

    func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
