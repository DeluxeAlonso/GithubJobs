//
//  ViewController.swift
//  GithubJobs
//
//  Created by Alonso on 29/06/22.
//

import UIKit
import Combine

class ViewController: UIViewController, Themeable {

    lazy private var closeBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeBarButtonItemTapped))
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

        updateUserInterfaceStyle(themeManager.interfaceStyle.value, animated: false)

        themeManager.interfaceStyle
            .dropFirst()
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userInterfaceStyle in
                guard let self = self else { return }
                self.updateUserInterfaceStyle(userInterfaceStyle, animated: true)
            }.store(in: &themeCancellable)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = shouldShowCloseBarButtonItem() ? closeBarButtonItem : nil
    }

    func shouldShowCloseBarButtonItem() -> Bool {
        return isBeingPresented || navigationController?.isBeingPresented ?? false
    }

    @objc func closeBarButtonItemTapped() {
        fatalError("Should be implemented in child class")
    }

}
