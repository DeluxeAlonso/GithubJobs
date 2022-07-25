//
//  SettingsViewController.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import UIKit
import Combine

final class SettingsViewController: ViewController {

    private let viewModel: SettingsViewModelProtocol
    private weak var coordinator: SettingsCoordinatorProtocol?

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializers

    init(themeManager: ThemeManagerProtocol,
         viewModel: SettingsViewModelProtocol,
         coordinator: SettingsCoordinatorProtocol) {
        self.viewModel = viewModel
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
