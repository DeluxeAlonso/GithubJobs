//
//  ViewController.swift
//  GithubJobs
//
//  Created by Alonso on 29/06/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    lazy private var closeBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeAction))
        return barButtonItem
    }()

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

        if shouldShowCloseBarButtonItem() {
            navigationItem.leftBarButtonItem = closeBarButtonItem
        }

        themeManager.interfaceStyle
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userInterfaceStyle in
                guard let self = self else { return }
                self.navigationController?.overrideUserInterfaceStyle = userInterfaceStyle
                self.overrideUserInterfaceStyle = userInterfaceStyle
            }.store(in: &themeCancellable)
    }

    @objc private func closeAction() {
        closeBarButtonItemTapped()
    }

    func shouldShowCloseBarButtonItem() -> Bool {
        return true
    }

    func closeBarButtonItemTapped() {

    }

}
