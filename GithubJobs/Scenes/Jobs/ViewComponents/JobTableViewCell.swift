//
//  JobTableViewCell.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    var viewModel: JobCellViewModel? {
        didSet {
            setupBindables()
        }
    }

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }

    // MARK: - Private

    private func setupUI() {
        accessoryType = .disclosureIndicator
        textLabel?.numberOfLines = 2

        detailTextLabel?.numberOfLines = 2
        detailTextLabel?.textColor = .systemGray
    }

    private func setupBindables() {
        guard let viewModel = viewModel else { return }
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.company
    }

}
