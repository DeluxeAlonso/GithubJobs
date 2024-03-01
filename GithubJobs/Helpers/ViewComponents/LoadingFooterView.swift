//
//  LoadingFooterView.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class LoadingFooterView: UIView {

    static let recommendedFrame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    convenience init() {
        self.init(frame: LoadingFooterView.recommendedFrame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private

    private func setupUI() {
        setupActivityIndicatorView()
    }

    private func setupActivityIndicatorView() {
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
    }

    // MARK: - Public

    func startAnimating() {
        activityIndicatorView.startAnimating()
    }

    func stopAnimating() {
        activityIndicatorView.stopAnimating()
    }

}
