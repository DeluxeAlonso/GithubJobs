//
//  JobsView.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class JobsView: UIView {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
