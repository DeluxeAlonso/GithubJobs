//
//  JobDetailSectionView.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class JobDetailSectionView: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .systemTeal
        label.font = FontHelper.dynamic(.body)
        label.adjustsFontForContentSizeCategory = true

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
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupUI() {
        backgroundColor = .systemBackground

        addSubview(titleLabel)
        titleLabel.fillSuperview()
    }

}
