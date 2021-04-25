//
//  ThemeManager.swift
//  GithubJobs
//
//  Created by Alonso on 24/04/21.
//

import UIKit
import Combine

class ThemeManager: ThemeManagerProtocol {

    static let shared = ThemeManager()

    init() {}

    lazy private(set) var appearance: CurrentValueSubject<UIUserInterfaceStyle, Never> = {
        return CurrentValueSubject<UIUserInterfaceStyle, Never>(userInterfaceStyle)
    }()

    var userInterfaceStyle: UIUserInterfaceStyle  {
        get {
            let interfaceStyleRawValue = UserDefaults.standard.integer(forKey: "GithubJobsUserInterfaceStyle")
            return UIUserInterfaceStyle(rawValue: interfaceStyleRawValue) ?? .unspecified
        }
        set {
            let inderfaceStyleRawValue = newValue.rawValue
            UserDefaults.standard.set(inderfaceStyleRawValue,
                                      forKey: "GithubJobsUserInterfaceStyle")
            appearance.value = newValue
        }
    }


}
