//
//  ThemeManagerProtocol.swift
//  GithubJobs
//
//  Created by Alonso on 24/04/21.
//

import Combine

protocol ThemeManagerProtocol: AnyObject {

    var theme: CurrentValueSubject<Theme, Never> { get }

    func updateTheme(_ theme: Theme)
    
}
