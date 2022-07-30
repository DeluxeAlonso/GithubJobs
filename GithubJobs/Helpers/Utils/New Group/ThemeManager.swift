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
        return CurrentValueSubject<UIUserInterfaceStyle, Never>(storedInterfaceStyle)
    }()

    func updateInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle) {
        self.storedInterfaceStyle = userInterfaceStyle
    }

    // MARK: - Private

    private var storedInterfaceStyle: UIUserInterfaceStyle {
        get {
            return UIUserInterfaceStyle(rawValue: userInterfaceStyleRawValue) ?? .unspecified
        }
        set {
            userInterfaceStyleRawValue = newValue.rawValue
            // We update the style subject value.
            interfaceStyle.value = newValue
        }
    }

}

extension UIUserInterfaceStyle: CustomStringConvertible {

    public var description: String {
        switch self {
        case .unspecified:
            return "System"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }

}
