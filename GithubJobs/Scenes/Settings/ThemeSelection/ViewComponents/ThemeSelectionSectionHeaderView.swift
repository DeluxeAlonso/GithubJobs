//
//  ThemeSelectionSectionHeaderView.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import UIKit

class ThemeSelectionSectionHeaderView: UICollectionReusableView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .footnote)

        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.fillSuperview(padding: .init(top: 16, left: 16, bottom: 8, right: 16))
    }

}
