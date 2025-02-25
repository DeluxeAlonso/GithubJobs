//
//  UIViewController+Extension.swift
//  GithubJobs
//
//  Created by Alonso on 22/02/25.
//

import UIKit

extension UIViewController {

    func add(asChildViewController viewController: UIViewController?) {
        guard let viewController else { return }

        addChild(viewController)

        view.addSubview(viewController.view)

        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }

    func add(asChildViewController viewController: UIViewController?, containerView: UIView) {
        guard let viewController, containerView.isDescendant(of: view) else {
            return
        }

        addChild(viewController)

        containerView.addSubview(viewController.view)

        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }

    func remove(asChildViewController viewController: UIViewController?) {
        guard let viewController else { return }

        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

}
