//
//  JobDetailHeaderView.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class JobDetailHeaderView: UIView {

    private lazy var companyLogoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.contentMode = .redraw
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var companyLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var logoURLString: String? {
        didSet {
            guard let urlString = logoURLString,
                  let url = URL(string: urlString) else {
                return
            }
            companyLogoImageView.setImage(with: url)
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

    private func setupUI() {
        addSubview(companyLogoContainerView)
        NSLayoutConstraint.activate([
            companyLogoContainerView.topAnchor.constraint(equalTo: topAnchor),
            companyLogoContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyLogoContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyLogoContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])

        companyLogoContainerView.addSubview(companyLogoImageView)
        NSLayoutConstraint.activate([
            companyLogoImageView.centerXAnchor.constraint(equalTo: companyLogoContainerView.centerXAnchor),
            companyLogoImageView.centerYAnchor.constraint(equalTo: companyLogoContainerView.centerYAnchor),
            companyLogoImageView.heightAnchor.constraint(equalToConstant: 85),
            companyLogoImageView.widthAnchor.constraint(equalToConstant: 85)
        ])

        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: companyLogoContainerView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

}
