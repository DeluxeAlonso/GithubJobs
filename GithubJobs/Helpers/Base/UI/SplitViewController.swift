//
//  SplitViewController.swift
//  GithubJobs
//
//  Created by Alonso on 23/07/22.
//

import UIKit
@preconcurrency import Combine

class SplitViewController: UISplitViewController, Themeable {

    private let themeManager: ThemeManagerProtocol

    var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializers

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        Task { @MainActor in
            let currentTheme = await themeManager.theme
            updateTheme(currentTheme, animated: false)

            await themeManager.themeSubject
                .dropFirst()
                .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] theme in
                    guard let self else { return }
                    self.updateTheme(theme, animated: true)
                }.store(in: &cancellables)
        }
    }

}
