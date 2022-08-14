//
//  RefreshControl.swift
//  GithubJobs
//
//  Created by Alonso on 14/08/22.
//

import UIKit
import Combine

class RefreshControl: UIRefreshControl {

    var valueChanged = PassthroughSubject<Void, Never>()

    init(title: String, backgroundColor: UIColor = .systemBackground) {
        super.init()
        self.attributedTitle = NSAttributedString(string: title)
        self.backgroundColor = backgroundColor
        self.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func refreshControlAction() {
        valueChanged.send()
    }

}
