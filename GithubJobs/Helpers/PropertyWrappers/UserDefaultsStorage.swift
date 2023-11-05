//
//  UserDefaultsStorage.swift
//  GithubJobs
//
//  Created by Alonso on 24/04/21.
//

import Foundation

@propertyWrapper
struct UserDefaultsStorage<T> {

    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }

}
