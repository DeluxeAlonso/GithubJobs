//
//  JobsViewController.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class JobsViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private var displayedCellsIndexPaths = Set<IndexPath>()

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Jobs"
        setupUI()
        setupBindings()
        viewModel.getAllJobs()
    }

    // MARK: - Private

    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperview()

        tableView.register(JobTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func setupBindings() {
        viewModel.viewState.bindAndFire { [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(with: state)
            strongSelf.tableView.reloadData()
        }
    }

    private func configureView(with state: JobsViewState) {
        switch state {
        case .empty:
            tableView.tableFooterView = CustomFooterView(message: "Empty")
        case .populated:
            tableView.tableFooterView = UIView()
        case .initial, .paging:
            tableView.tableFooterView = LoadingFooterView()
        case .error(let error):
            tableView.tableFooterView = CustomFooterView(message: error.description)
        }
    }

}

// MARK: - UITableViewDataSource

extension JobsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jobsCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! JobTableViewCell
        cell.viewModel = viewModel.jobsCells[indexPath.row]

        return cell
    }

}

// MARK: - UITableViewDelegate

extension JobsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            TableViewCellAnimator.fadeAnimate(cell: cell)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
