//
//  UIViewController+Theme.swift
//  GithubJobs
//
//  Created by Alonso on 9/08/22.
//

import UIKit

protocol Themeable {

    func updateUserInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle, animated: Bool)

}

extension Themeable where Self: UIViewController {

    func updateUserInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle, animated: Bool) {
        if animated {
            UIView.transition(with: view, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.overrideUserInterfaceStyle = userInterfaceStyle
            }, completion: nil)

            guard let navigationControllerView = navigationController?.view else { return }
            UIView.transition(with: navigationControllerView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.navigationController?.overrideUserInterfaceStyle = userInterfaceStyle
            }, completion: nil)
        } else {
            overrideUserInterfaceStyle = userInterfaceStyle
            navigationController?.overrideUserInterfaceStyle = userInterfaceStyle
        }
    }
    
}
