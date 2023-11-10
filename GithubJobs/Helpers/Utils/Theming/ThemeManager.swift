//
//  ThemeManager.swift
//  GithubJobs
//
//  Created by Alonso on 24/04/21.
//

import UIKit
import Combine

final class ThemeManager: ThemeManagerProtocol {

    static let shared = ThemeManager()

    @UserDefaultsStorage(key: "UserInterfaceStyle", defaultValue: UIUserInterfaceStyle.unspecified.rawValue)
    private var userInterfaceStyleRawValue: Int

    init() {}

    // MARK: - ThemeManagerProtocol

    lazy private(set) var interfaceStyle: CurrentValueSubject<UIUserInterfaceStyle, Never> = {
        CurrentValueSubject<UIUserInterfaceStyle, Never>(storedInterfaceStyle)
    }()

    func updateInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle) {
        self.storedInterfaceStyle = userInterfaceStyle
    }

    // MARK: - Private

    private var storedInterfaceStyle: UIUserInterfaceStyle {
        get {
            UIUserInterfaceStyle(rawValue: userInterfaceStyleRawValue) ?? .unspecified
        }
        set {
            userInterfaceStyleRawValue = newValue.rawValue
            // We update the style subject value.
            interfaceStyle.value = newValue
        }
    }

}

// MARK: - CustomStringConvertible

extension UIUserInterfaceStyle: CustomStringConvertible {

    public var description: String {
        switch self {
        case .unspecified:
            return "System"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        @unknown default:
            return "Unknown"
        }
    }

}
