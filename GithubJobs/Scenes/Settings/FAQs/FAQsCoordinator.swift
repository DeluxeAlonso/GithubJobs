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
        // TODO
    }

    func dismiss() {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
