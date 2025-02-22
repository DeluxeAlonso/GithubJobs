//
//  UIViewController+Extension.swift
//  GithubJobs
//
//  Created by Alonso on 22/02/25.
//

import UIKit

extension UIViewController {

    func add(asChildViewController viewController: UIViewController?) {
        guard let viewController = viewController else { return }

        addChild(viewController)

        view.addSubview(viewController.view)

        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }

    func add(asChildViewController viewController: UIViewController?, containerView: UIView) {
        guard let viewController = viewController, containerView.isDescendant(of: view) else {
            return
        }

        addChild(viewController)

        containerView.addSubview(viewController.view)

        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        viewController.didMove(toParent: self)
    }

    func remove(asChildViewController viewController: UIViewController?) {
        guard let viewController = viewController else { return }

        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    // MARK: - Navigation Controller

    func setTitleAnimated(_ title: String?,
                          with transitionType: CATransitionType = .fade,
                          animated: Bool = false) {
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = animated ? 0.5 : 0.0
        fadeTextAnimation.type = transitionType

        navigationController?.navigationBar.layer.add(fadeTextAnimation,
                                                      forKey: "animateText")
        navigationItem.title = title
    }

    // MARK: - Navigation Bar

    func setClearAppearanceNavigationBar() {
        // It is recommended by apple to set the appearance for the navigation
        // item when configuring the navigation appearance of a specific view controller
        // https://developer.apple.com/forums/thread/683590
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
    }

    func setDefaultAppearanceNavigationBar(with barTintColor: UIColor) {
        // It is recommended by apple to set the appearance for the navigation
        // item when configuring the navigation appearance of a specific view controller
        // https://developer.apple.com/forums/thread/683590
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }

    var navigationBarHeight: CGFloat {
        guard let navigationController = navigationController else { return 0 }

        let top = navigationController.navigationBar.intrinsicContentSize.height

        let window = UIApplication.shared.keyWindow
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

        let navBarHeight = top + statusBarHeight

        return navBarHeight
    }

    // MARK: - Deep Link Handling

    func openDeepLinkURL(_ url: URL?) {
        let application = UIApplication.shared
        guard let url = url, application.canOpenURL(url) else { return }
        application.open(url, options: [:], completionHandler: nil)
    }

}
