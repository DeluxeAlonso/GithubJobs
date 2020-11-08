//
//  JobDetailViewController.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class JobDetailViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    var headerView: JobDetailHeaderView!

    private let viewModel: JobDetailViewModelProtocol
    private weak var coordinator: JobDetailCoordinatorProtocol?
    
    // MARK: - Initializers

    init(viewModel: JobDetailViewModelProtocol, coordinator: JobDetailCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupBindings()
        viewModel.getRelatedJobs()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let headerView = tableView.tableHeaderView {
            let newSize = headerView.systemLayoutSizeFitting(CGSize(width: self.view.bounds.width, height: 0))
            if newSize.height != headerView.frame.size.height {
                headerView.frame.size.height = newSize.height
                tableView.tableHeaderView = headerView
            }
        }
    }

    // MARK: - Private

    private func setupUI() {
        setupTableView()
        setupHeaderView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        tableView.register(JobTableViewCell.self, forCellReuseIdentifier: "Cell")

        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupHeaderView() {
        headerView = JobDetailHeaderView()
        headerView.frame = .init(x: 0, y:0, width: view.frame.width, height: view.frame.height)

        tableView.tableHeaderView = headerView
    }

    private func configureView(with state: JobDetailViewState) {
        switch state {
        case .empty:
            tableView.tableFooterView = CustomFooterView(message: "No jobs to show")
        case .populated:
            tableView.tableFooterView = UIView()
        case .initial:
            tableView.tableFooterView = LoadingFooterView()
        case .error(let error):
            tableView.tableFooterView = CustomFooterView(message: error.description)
        }
    }

    // MARK: - Reactive Behaviour

    private func setupBindings() {
        title = viewModel.jobTitle
        headerView.title = viewModel.jobDescription

        viewModel.viewState.bindAndFire { [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(with: state)
            strongSelf.tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource

extension JobDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! JobTableViewCell
        cell.viewModel = viewModel.jobsCells[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jobsCells.count
    }

}

// MARK: - UITableViewDelegate

extension JobDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = JobDetailSectionView()
        view.title = "Related jobs"
        return view
    }

}
