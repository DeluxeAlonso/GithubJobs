//
//  ThemeManagerProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 24/04/21.
//

import UIKit
import Combine

protocol ThemeManagerProtocol: AnyObject {

    var interfaceStyle: CurrentValueSubject<UIUserInterfaceStyle, Never> { get }

    func updateInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle)
    
}
