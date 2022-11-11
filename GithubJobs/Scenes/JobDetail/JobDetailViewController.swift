//
//  JobDetailViewController.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit
import Combine

final class JobDetailViewController: ViewController {

    private lazy var headerView: JobDetailHeaderView = {
        let headerView = JobDetailHeaderView()
        headerView.viewModel = viewModel.makeJobDetailHeaderViewModel()

        return headerView
    }()

    private lazy var refreshControl: RefreshControl = {
        let refreshControl = RefreshControl(title: LocalizedStrings.refreshControlTitle(), backgroundColor: .systemBackground)
        return refreshControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private var displayedCellsIndexPaths = Set<IndexPath>()

    private let viewModel: JobDetailViewModelProtocol
    private weak var coordinator: JobDetailCoordinatorProtocol?

    // MARK: - Initializers

    init(themeManager: ThemeManagerProtocol,
         viewModel: JobDetailViewModelProtocol,
         coordinator: JobDetailCoordinatorProtocol) {
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
        setupUI()
        setupBindings()
        viewModel.getRelatedJobs()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Recalculate header height if needed
        if let headerView = tableView.tableHeaderView {
            let newSize = headerView.systemLayoutSizeFitting(CGSize(width: tableView.bounds.width, height: 0))
            if newSize.height != headerView.frame.size.height {
                headerView.frame.size.height = newSize.height
                tableView.tableHeaderView = headerView
            }
        }
    }

    // MARK: - Private

    private func setupUI() {
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        tableView.register(cellType: JobTableViewCell.self)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.refreshControl = refreshControl

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        configureHeaderView()
    }

    private func configureView(with state: JobDetailViewState) {
        switch state {
        case .empty:
            tableView.tableFooterView = CustomFooterView(message: LocalizedStrings.emptyRelatedJobsTitle())
        case .populated:
            tableView.tableFooterView = UIView()
        case .initial:
            tableView.tableFooterView = LoadingFooterView()
        case .error(let error):
            tableView.tableFooterView = CustomFooterView(message: error.description)
        }
    }

    private func configureHeaderView() {
        headerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.tableHeaderView = headerView
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        title = viewModel.jobTitle

        refreshControl
            .valueChanged
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
                self.viewModel.getRelatedJobs()
            }.store(in: &cancellables)

        viewModel.viewStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                self.configureView(with: state)
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }.store(in: &cancellables)
    }

}

// MARK: - UITableViewDataSource

extension JobDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: JobTableViewCell.self, for: indexPath)
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
        coordinator?.showJobDetail(viewModel.job(at: indexPath.row))
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = JobDetailSectionView()
        view.title = LocalizedStrings.relatedJobsTitle()
        return view
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !displayedCellsIndexPaths.contains(indexPath) {
            displayedCellsIndexPaths.insert(indexPath)
            Animator.fade(tableViewCell: cell)
        }
    }

}
