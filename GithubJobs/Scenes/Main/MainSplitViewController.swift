//
//  MainSplitViewController.swift
//  GithubJobs
//
//  Created by Alonso on 8/05/21.
//

import UIKit

final class MainSplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    // MARK: - Initializers

    init(preferredDisplayMode: UISplitViewController.DisplayMode) {
        super.init(nibName: nil, bundle: nil)
        self.preferredDisplayMode = preferredDisplayMode
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    // MARK: - UISplitViewControllerDelegate

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}
