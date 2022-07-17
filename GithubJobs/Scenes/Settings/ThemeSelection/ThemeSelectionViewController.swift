//
//  ThemeSelectionViewController.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import Combine
import UIKit

typealias ThemeModel = ThemeSelectionViewModel.ThemeModel
typealias ThemeSelectionCollectionViewDataSource = UICollectionViewDiffableDataSource<ThemeSelectionSection, ThemeModel>

final class ThemeSelectionViewController: ViewController, UICollectionViewDelegate {

    lazy private var closeBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeAction))
        return barButtonItem
    }()

    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(viewType: SettingsSectionHeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let viewModel: ThemeSelectionViewModelProtocol
    private weak var coordinator: ThemeSelectionCoordinatorProtocol?

    private var dataSource: ThemeSelectionCollectionViewDataSource?
    private var cancellables: Set<AnyCancellable> = []

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

        setupBindings()
    }

    // MARK: - Private

    private func configureUI() {
        title = "Theme selection"

        navigationItem.leftBarButtonItem = closeBarButtonItem

        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        collectionView.fillSuperview(padding: .zero)
        configureCollectionViewLayout()
    }

    private func configureCollectionView() {
        
    }

    private func configureCollectionViewLayout() {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.headerMode = .supplementary

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.collectionViewLayout = layout
    }

    private func configureCollectionViewDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ThemeModel> { cell, _, theme in
            var content = UIListContentConfiguration.valueCell()

            content.text = theme.title
            content.textToSecondaryTextVerticalPadding = 4
            content.secondaryTextProperties.numberOfLines = 0

            cell.contentConfiguration = content
        }

        dataSource = ThemeSelectionCollectionViewDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, identifier in
            guard let self = self else { fatalError() }
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath, item: identifier)
            let theme = self.viewModel.themes[indexPath.row]
            cell.accessories = [.checkmark(displayed: .always, options: .init(isHidden: !theme.isSelected))]
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
        var snapshot = NSDiffableDataSourceSnapshot<ThemeSelectionSection, ThemeModel>()
        snapshot.appendSections([ThemeSelectionSection.main])
        snapshot.appendItems(viewModel.themes, toSection: ThemeSelectionSection.main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    private func setupBindings() {
        viewModel.didSelectTheme
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.updateUI()
            }.store(in: &cancellables)
    }

    // MARK: - Selectors

    @objc private func closeAction() {
        coordinator?.dismiss()
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectTheme(at: indexPath.row)
    }

}
