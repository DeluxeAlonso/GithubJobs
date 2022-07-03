//
//  AppDelegate.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit
import Kingfisher

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureGlobalAppearanceIfNeeded()
        ImageCache.default.memoryStorage.config.totalCostLimit = 1000
        return true
    }
    
}

extension AppDelegate {

    /**
     Configures UINavigationBar an UITabBar appearance to have a similar behavior as pre-iOS15.

     In iOS 15, UIKit has extended the usage of the scrollEdgeAppearance,
     which by default produces a transparent background, to all navigation bars.
     The background is controlled by when your scroll view scrolls
     content behind the navigation bar.
     */
    func configureGlobalAppearanceIfNeeded() {
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance

            let tabBarAppearance = UITabBarAppearance()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = UITabBar.appearance().standardAppearance
        }
    }

}
