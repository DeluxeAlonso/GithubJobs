//
//  SettingsViewController.swift
//  GithubJobs
//
//  Created by Alonso on 24/07/22.
//

import UIKit
import Combine

typealias SettingsCollectionViewDataSource = UICollectionViewDiffableDataSource<SettingsSection, SettingsItemModel>

final class SettingsViewController: ViewController, UICollectionViewDelegate {

    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(viewType: ThemeSelectionSectionHeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let viewModel: SettingsViewModelProtocol
    private weak var coordinator: SettingsCoordinatorProtocol?

    private var dataSource: SettingsCollectionViewDataSource?
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializers

    init(themeManager: ThemeManagerProtocol,
         viewModel: SettingsViewModelProtocol,
         coordinator: SettingsCoordinatorProtocol) {
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
        setupBindings()
    }

    override func closeBarButtonItemTapped() {
        coordinator?.dismiss()
    }

    // MARK: - Private

    private func configureUI() {
        title = "Settings"

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
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SettingsItemModel> { cell, _, item in
            var content = UIListContentConfiguration.valueCell()

            content.text = item.title
            content.secondaryText = item.value
            content.textToSecondaryTextVerticalPadding = 4
            content.secondaryTextProperties.numberOfLines = 0

            cell.contentConfiguration = content
        }

        dataSource = SettingsCollectionViewDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, identifier in
            guard let self = self else { fatalError() }
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath, item: identifier)
            cell.accessories = [.disclosureIndicator()]
            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            let headerView = collectionView.dequeueReusableView(with: ThemeSelectionSectionHeaderView.self,
                                                                kind: UICollectionView.elementKindSectionHeader,
                                                                for: indexPath)
            headerView.title = nil
            return headerView
        }
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        viewModel.didSelectThemeSelectionItem
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.coordinator?.showThemeSelection()
            }.store(in: &cancellables)

        viewModel.itemModelsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] items in
                guard let self = self else { return }
                self.updateUI(with: items)
            }.store(in: &cancellables)
    }

    private func updateUI(with items: [SettingsItemModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<SettingsSection, SettingsItemModel>()
        snapshot.appendSections([SettingsSection.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath.item)
    }

}
