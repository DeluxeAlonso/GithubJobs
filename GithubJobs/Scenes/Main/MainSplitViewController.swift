//
//  MainSplitViewController.swift
//  GithubJobs
//
//  Created by Alonso on 8/05/21.
//

import UIKit

final class MainSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = UISplitViewController.DisplayMode.oneBesideSecondary
    }

    // MARK: - UISplitViewControllerDelegate

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}
