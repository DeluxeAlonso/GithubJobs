//
//  JobTableViewCell.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupUI() {
        accessoryType = .disclosureIndicator
    }

}
