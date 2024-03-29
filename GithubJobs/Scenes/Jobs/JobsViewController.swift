//
//  JobsViewController.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit
import Combine

final class JobsViewController: ViewController {

    private lazy var themeSelectionBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: .init(systemName: "gear"),
                                            landscapeImagePhone: .init(systemName: "gearshape.2"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(settingsAction))
        return barButtonItem
    }()

    private lazy var refreshControl: RefreshControl = {
        let refreshControl = RefreshControl(title: LocalizedStrings.refreshControlTitle(), backgroundColor: .systemBackground)
        return refreshControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(cellType: JobTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        tableView.refreshControl = refreshControl

        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private var displayedCellsIndexPaths = Set<IndexPath>()
    private var prefetchDataSource: TableViewDataSourcePrefetching?

    private let viewModel: JobsViewModelProtocol
    private weak var coordinator: JobsCoordinatorProtocol?

    // MARK: - Initializers

    init(themeManager: ThemeManagerProtocol,
         viewModel: JobsViewModelProtocol,
         coordinator: JobsCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(themeManager: themeManager)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = LocalizedStrings.jobsTitle()

        setupUI()
        setupBindings()
        viewModel.getJobs()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    // MARK: - Private

    private func setupUI() {
        navigationItem.rightBarButtonItem = themeSelectionBarButtonItem

        view.addSubview(tableView)
        tableView.fillSuperview()
    }

    private func configureTableViewDataSource() {
        prefetchDataSource = TableViewDataSourcePrefetching(cellCount: viewModel.jobsCells.count,
                                                            needsPrefetch: viewModel.needsPrefetch,
                                                            prefetchHandler: { [weak self] in
            self?.viewModel.refreshJobs()
        })
        tableView.prefetchDataSource = prefetchDataSource
    }

    private func configureView(with state: JobsViewState) {
        switch state {
        case .empty:
            tableView.tableFooterView = CustomFooterView(message: LocalizedStrings.emptyJobsTitle())
        case .populated, .paging:
            tableView.tableFooterView = UIView()
        case .initial:
            tableView.tableFooterView = LoadingFooterView()
        case .error(let error):
            tableView.tableFooterView = CustomFooterView(message: error.description)
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        refreshControl
            .valueChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
                self.viewModel.getJobs()
            }.store(in: &cancellables)

        viewModel
            .viewStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                self.configureView(with: state)
                self.configureTableViewDataSource()
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }.store(in: &cancellables)
    }

    // MARK: - Selectors

    @objc private func settingsAction() {
        coordinator?.showSettings()
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
            Animator.fade(tableViewCell: cell)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showJobDetail(viewModel.job(at: indexPath.row))
    }

}
