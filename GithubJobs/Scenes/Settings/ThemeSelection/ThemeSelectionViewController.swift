//
//  ThemeSelectionViewController.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import Combine
import UIKit

typealias ThemeSelectionCollectionViewDataSource = UICollectionViewDiffableDataSource<ThemeSelectionSection, ThemeSelectionItemModel>

final class ThemeSelectionViewController: ViewController, UICollectionViewDelegate {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(viewType: ThemeSelectionSectionHeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let viewModel: ThemeSelectionViewModelProtocol
    private weak var coordinator: ThemeSelectionCoordinatorProtocol?

    private var dataSource: ThemeSelectionCollectionViewDataSource?

    // MARK: - Initializers

    init(themeManager: ThemeManagerProtocol,
         viewModel: ThemeSelectionViewModelProtocol,
         coordinator: ThemeSelectionCoordinatorProtocol) {
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

        configureUI()
        updateUI()

        setupBindings()
    }

    override func closeBarButtonItemTapped() {
        coordinator?.dismiss()
    }

    // MARK: - Private

    private func configureUI() {
        title = viewModel.screenTitle()

        view.backgroundColor = .systemBackground

        configureCollectionView()
    }

    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillSuperview(padding: .zero)

        configureCollectionViewLayout()
        configureCollectionViewDataSource()
    }

    private func configureCollectionViewLayout() {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.headerMode = .supplementary

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.collectionViewLayout = layout
    }

    private func configureCollectionViewDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ThemeSelectionItemModel> { cell, _, theme in
            var content = UIListContentConfiguration.valueCell()

            content.text = theme.title
            content.textToSecondaryTextVerticalPadding = 4
            content.secondaryTextProperties.numberOfLines = 0

            cell.contentConfiguration = content
        }

        dataSource = ThemeSelectionCollectionViewDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, identifier in
            guard let self = self else { fatalError("Inconsistent state") }
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath, item: identifier)
            let theme = self.viewModel.themes[indexPath.row]
            cell.accessories = [.checkmark(displayed: .always, options: .init(isHidden: !theme.isSelected))]
            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableView(with: ThemeSelectionSectionHeaderView.self,
                                                                kind: UICollectionView.elementKindSectionHeader,
                                                                for: indexPath)
            headerView.title = self?.viewModel.headerTitle(for: indexPath.section)
            return headerView
        }
    }

    private func updateUI() {
        var snapshot = NSDiffableDataSourceSnapshot<ThemeSelectionSection, ThemeSelectionItemModel>()
        snapshot.appendSections([ThemeSelectionSection.main])
        snapshot.appendItems(viewModel.themes, toSection: ThemeSelectionSection.main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    private func setupBindings() {
        viewModel.didSelectTheme
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
                self.updateUI()
            }.store(in: &cancellables)
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectTheme(at: indexPath.row)
    }

}
