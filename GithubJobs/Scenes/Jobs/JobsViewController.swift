//
//  JobsViewController.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class JobsViewController: UIViewController {

    private var jobsView: JobsView!
    private let viewModel: JobsViewModelProtocol

    // MARK: - Initializers

    init(viewModel: JobsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        jobsView = JobsView()
        self.view = jobsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getAllJobs()
    }

    // MARK: - Private

    private func setupUI() {
        jobsView.tableView.register(JobTableViewCell.self, forCellReuseIdentifier: "Cell")
        jobsView.tableView.dataSource = self
    }

}

// MARK: - UITableViewDataSource

extension JobsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Subtitle"

        return cell
    }

}

// MARK: - UITableViewDelegate

extension JobsViewController: UITableViewDelegate {

}
