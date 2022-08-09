//
//  SplitViewController.swift
//  GithubJobs
//
//  Created by Alonso on 23/07/22.
//

import UIKit
import Combine

class SplitViewController: UISplitViewController {

    private let themeManager: ThemeManagerProtocol

    private var themeCancellable: Set<AnyCancellable> = []

    init(themeManager: ThemeManagerProtocol) {
        self.themeManager = themeManager
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.overrideUserInterfaceStyle = themeManager.interfaceStyle.value
        self.overrideUserInterfaceStyle = themeManager.interfaceStyle.value

        themeManager.interfaceStyle
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userInterfaceStyle in
                guard let self = self else { return }
                UIView.transition(with: self.view, duration: 1.0, options: .transitionCrossDissolve, animations: {
                    self.navigationController?.overrideUserInterfaceStyle = userInterfaceStyle
                    self.overrideUserInterfaceStyle = userInterfaceStyle
                }, completion: nil)
            }.store(in: &themeCancellable)
    }

}
