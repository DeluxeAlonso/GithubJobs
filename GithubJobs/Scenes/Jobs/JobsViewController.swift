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
    private var prefetchDataSource: TableViewDataSourcePrefetching!

    private let viewModel: JobsViewModelProtocol
    private weak var coordinator: JobsCoordinatorProtocol?

    // MARK: - Initializers

    init(viewModel: JobsViewModelProtocol, coordinator: JobsCoordinatorProtocol) {
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
        title = LocalizedStrings.jobsTitle.localized
        setupUI()
        setupBindings()
        viewModel.getJobs()
    }

    // MARK: - Private

    private func setupUI() {
        view.addSubview(tableView)
        tableView.fillSuperview()

        tableView.register(cellType: JobTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func configureTableViewDataSource() {
        prefetchDataSource = TableViewDataSourcePrefetching(cellCount: viewModel.jobsCells.count,
                                                            needsPrefetch: viewModel.needsPrefetch,
                                                            prefetchHandler: { [weak self] in
                                                                self?.viewModel.getJobs()
        })
        tableView.prefetchDataSource = prefetchDataSource
    }

    private func configureView(with state: JobsViewState) {
        switch state {
        case .empty:
            tableView.tableFooterView = CustomFooterView(message: LocalizedStrings.emptyJobsTitle.localized)
        case .populated:
            tableView.tableFooterView = UIView()
        case .initial, .paging:
            tableView.tableFooterView = LoadingFooterView()
        case .error(let error):
            tableView.tableFooterView = CustomFooterView(message: error.description)
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        viewModel.viewState.bindAndFire { [weak self] state in
            guard let strongSelf = self else { return }
            strongSelf.configureView(with: state)
            strongSelf.configureTableViewDataSource()
            strongSelf.tableView.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource

extension JobsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jobsCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: JobTableViewCell.self, for: indexPath)
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
        coordinator?.showJobDetail(viewModel.job(at: indexPath.row))
    }

}
