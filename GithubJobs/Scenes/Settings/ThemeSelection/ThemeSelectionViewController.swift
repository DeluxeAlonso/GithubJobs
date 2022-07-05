//
//  ThemeSelectionViewController.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import UIKit

class ThemeSelectionViewController: ViewController {

    private weak var coordinator: ThemeSelectionCoordinatorProtocol?

    init(themeManager: ThemeManagerProtocol, coordinator: ThemeSelectionCoordinatorProtocol) {
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
