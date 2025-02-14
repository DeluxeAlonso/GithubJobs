//
//  SplitViewController.swift
//  GithubJobs
//
//  Created by Alonso on 23/07/22.
//

import UIKit
import Combine

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

        updateTheme(themeManager.theme.value, animated: false)

        themeManager.theme
            .dropFirst()
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] theme in
                guard let self else { return }
                self.updateTheme(theme, animated: true)
            }.store(in: &cancellables)

//        themeManager.interfaceStyle
//            .dropFirst()
//            .removeDuplicates()
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] userInterfaceStyle in
//                guard let self else { return }
//                self.updateUserInterfaceStyle(userInterfaceStyle, animated: true)
//            }.store(in: &cancellables)
    }

}
