//
//  SceneDelegate.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class EmptyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

}

class PrimarySplitViewController: UISplitViewController,
                                  UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = UISplitViewController.DisplayMode.oneBesideSecondary
    }

    func splitViewController(
             _ splitViewController: UISplitViewController,
             collapseSecondary secondaryViewController: UIViewController,
             onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }

}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: Coordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowsScene)

        mainCoordinator = JobsCoordinator(navigationController: UINavigationController())
        mainCoordinator.start()

        let splitVC = PrimarySplitViewController()
        splitVC.viewControllers = [mainCoordinator.navigationController,
                                   UINavigationController(rootViewController: EmptyViewController())]

        self.window?.rootViewController = splitVC//mainCoordinator.navigationController
        self.window?.makeKeyAndVisible()
    }

}
