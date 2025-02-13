//
//  ThemeManagerProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 24/04/21.
//

import UIKit
import Combine

protocol ThemeManagerProtocol: AnyObject {

    var theme: CurrentValueSubject<Theme, Never> { get }

    func updateTheme(_ theme: Theme)

    var interfaceStyle: CurrentValueSubject<UIUserInterfaceStyle, Never> { get }

    func updateInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle)
    
}
