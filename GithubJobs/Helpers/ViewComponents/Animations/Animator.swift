//
//  Animator.swift
//  GithubJobs
//
//  Created by Alonso on 20/10/22.
//

import UIKit

class Animator {

    class func fade(view: UIView) {
        view.layer.opacity = 0.1
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: {
            view.layer.opacity = 1
        }, completion: nil)
    }

    class func fade(tableViewCell: UITableViewCell) {
        let view = tableViewCell.contentView
        view.layer.opacity = 0.1
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: {
            view.layer.opacity = 1
        }, completion: nil)
    }

}
