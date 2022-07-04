//
//  JobDetailViewController.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit
import Combine

final class JobDetailViewController: ViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private var headerView: JobDetailHeaderView!
    private var displayedCellsIndexPaths = Set<IndexPath>()
    private var cancellables: Set<AnyCancellable> = []

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

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
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
        headerView = JobDetailHeaderView()
        headerView.viewModel = viewModel.makeJobDetailHeaderViewModel()

        headerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

        tableView.tableHeaderView = headerView
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        title = viewModel.jobTitle

        configureHeaderView()

        viewModel.viewStatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let strongSelf = self else { return }
                strongSelf.configureView(with: state)
                strongSelf.tableView.reloadData()
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
            TableViewCellAnimator.fadeAnimate(cell: cell)
        }
    }

}
