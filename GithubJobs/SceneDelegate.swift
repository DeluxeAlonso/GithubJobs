//
//  SceneDelegate.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowsScene)
        self.window?.rootViewController = UINavigationController(rootViewController: JobsViewController())
        self.window?.makeKeyAndVisible()
    }

}
