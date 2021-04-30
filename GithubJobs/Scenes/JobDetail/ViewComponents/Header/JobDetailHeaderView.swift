//
//  JobDetailHeaderView.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class JobDetailHeaderView: UIView {

    private lazy var companyLogoContainerView: BackgroundCurvedView = {
        let view = BackgroundCurvedView()
        view.backgroundColor = .systemTeal
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

    var viewModel: JobDetailHeaderViewModelProtocol? {
        didSet {
            setupBindings()
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
        setupCompanyLogoView()
        setupTitleLabel()
    }

    private func setupCompanyLogoView() {
        addSubview(companyLogoContainerView)
        NSLayoutConstraint.activate([
            companyLogoContainerView.topAnchor.constraint(equalTo: topAnchor),
            companyLogoContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyLogoContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyLogoContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])

        companyLogoContainerView.addSubview(companyLogoImageView)
        companyLogoImageView.centerInSuperview(size: .init(width: 80, height: 80))
    }

    private func setupTitleLabel() {
        addSubview(titleLabel)

        let trailingContraint = titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        let leadingContraint = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)

        // Add a 999 priority to supress width constraint warning.
        trailingContraint.priority = .init(999)
        leadingContraint.priority = .init(999)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: companyLogoContainerView.bottomAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            leadingContraint,
            trailingContraint
        ])
    }

    // MARK: - Reactive Behavior

    private func setupBindings() {
        guard let viewModel = viewModel else { return }

        titleLabel.text = viewModel.jobDescription

        guard let urlString = viewModel.companyLogoURLString,
              let url = URL(string: urlString) else {
            return
        }
        companyLogoImageView.setImage(with: url)
    }

}
