//
//  UIImageView+Kingfisher.swift
//  GithubJobs
//
//  Created by Alonso on 11/8/20.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(with url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }

}
