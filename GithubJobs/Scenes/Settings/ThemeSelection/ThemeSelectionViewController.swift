//
//  ThemeSelectionViewController.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import UIKit

typealias ThemeSelectionCollectionViewDataSource = UICollectionViewDiffableDataSource<ThemeSelectionSection, Theme>

class ThemeSelectionViewController: ViewController {

    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let viewModel: ThemeSelectionViewModelProtocol
    private weak var coordinator: ThemeSelectionCoordinatorProtocol?

    private var dataSource: ThemeSelectionCollectionViewDataSource?

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
        configureCollectionViewLayout()
        configureCollectionViewDataSource()

        updateUI()
    }

    // MARK: - Private

    private func configureUI() {
        collectionView.register(viewType: SettingsSectionHeaderView.self, kind: UICollectionView.elementKindSectionHeader)

        configureCollectionViewLayout()
    }

    private func configureCollectionViewLayout() {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.headerMode = .supplementary

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.collectionViewLayout = layout
    }

    private func configureCollectionViewDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Theme> { [weak self] cell, _, theme in
            var content = UIListContentConfiguration.sidebarCell()

            content.text = self?.viewModel.title(for: theme)
            content.textToSecondaryTextVerticalPadding = 4
            content.secondaryTextProperties.numberOfLines = 0

            cell.contentConfiguration = content
        }

        dataSource = ThemeSelectionCollectionViewDataSource(collectionView: collectionView) { collectionView, indexPath, identifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath, item: identifier)
            cell.accessories = [.disclosureIndicator()]
            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableView(with: SettingsSectionHeaderView.self,
                                                                kind: UICollectionView.elementKindSectionHeader,
                                                                for: indexPath)
            headerView.title = self?.viewModel.headerTitle(for: indexPath.section)
            return headerView
        }
    }

    private func updateUI() {
        var snapshot = NSDiffableDataSourceSnapshot<ThemeSelectionSection, Theme>()
        snapshot.appendSections([ThemeSelectionSection.main])
        snapshot.appendItems(viewModel.themes, toSection: ThemeSelectionSection.main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

}
