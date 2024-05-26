//
//  CustomFooterView.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class CustomFooterView: UIView {

    private static let recommendedFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = FontHelper.dynamic(.body)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    init(message: String, frame: CGRect = CustomFooterView.recommendedFrame) {
        super.init(frame: frame)
        setupUI()
        messageLabel.text = message
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupUI() {
        addSubview(messageLabel)
        messageLabel.fillSuperview(padding: .init(top: 0, left: Constants.horizontalMargin,
                                                  bottom: 0, right: Constants.horizontalMargin))
    }

    // MARK: - Constants

    struct Constants {
        static let horizontalMargin: CGFloat = 8.0
    }

}
