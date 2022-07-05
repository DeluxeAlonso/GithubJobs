//
//  ThemeSelectionViewController.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import UIKit

enum Theme: CaseIterable {
    case light, dark, system

    var title: String? {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }
}

enum ThemeSelectionSection {
    case main

    var title: String? {
        switch self {
        case .main:
            return "Theme"
        }
    }

    var themes: [Theme] {
        switch self {
        case .main:
            return Theme.allCases
        }
    }
}

class ThemeSelectionViewController: ViewController {

    lazy private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<ThemeSelectionSection, Theme>!

    private weak var coordinator: ThemeSelectionCoordinatorProtocol?

    init(themeManager: ThemeManagerProtocol, coordinator: ThemeSelectionCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(themeManager: themeManager)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configureUI() {
        collectionView.register(viewType: SettingsSectionHeaderView.self, kind: UICollectionView.elementKindSectionHeader)

        configureCollectionViewLayout()
        //configureCollectionViewDataSource()
        //updateUI()
    }

    private func configureCollectionViewLayout() {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.headerMode = .supplementary

        let layout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.collectionViewLayout = layout
    }

    private func configureCollectionViewDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Theme> { cell, _, item in
            var content = UIListContentConfiguration.sidebarCell()

            content.text = item.title
            content.textToSecondaryTextVerticalPadding = 4
            content.secondaryTextProperties.numberOfLines = 0

            cell.contentConfiguration = content
        }

        dataSource = UICollectionViewDiffableDataSource<ThemeSelectionSection, Theme>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Theme) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath, item: identifier)
            cell.accessories = [.disclosureIndicator()]
            return cell
        }

        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            let headerView = collectionView.dequeueReusableView(with: SettingsSectionHeaderView.self,
                                                                kind: UICollectionView.elementKindSectionHeader,
                                                                for: indexPath)
            headerView.title = "Theme"
            return headerView
        }
    }

}
