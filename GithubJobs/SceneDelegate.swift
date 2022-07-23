//
//  SceneDelegate.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: Coordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowsScene)

        mainCoordinator = JobsCoordinator(navigationController: UINavigationController())
        mainCoordinator.start()

        let splitVC = MainSplitViewController(themeManager: ThemeManager.shared,
                                              preferredDisplayMode: .oneBesideSecondary)
        splitVC.viewControllers = [mainCoordinator.navigationController, EmptyDetailViewController(themeManager: ThemeManager.shared)]

        self.window?.rootViewController = splitVC
        self.window?.makeKeyAndVisible()
    }

}
