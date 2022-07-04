//
//  SettingsViewController.swift
//  GithubJobs
//
//  Created by Alonso on 3/07/22.
//

import UIKit

class SettingsViewController: ViewController {

    private weak var coordinator: SettingsCoordinatorProtocol?

    init(themeManager: ThemeManagerProtocol, coordinator: SettingsCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(themeManager: themeManager)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
