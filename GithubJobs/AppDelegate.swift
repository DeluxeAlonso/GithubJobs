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
        ImageCache.default.memoryStorage.config.totalCostLimit = 1000
        return true
    }
    
}
