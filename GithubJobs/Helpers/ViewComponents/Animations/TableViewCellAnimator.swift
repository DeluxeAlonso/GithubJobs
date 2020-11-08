//
//  TableViewCellAnimator.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

class TableViewCellAnimator {

    class func fadeAnimate(cell: UITableViewCell) {
        let view = cell.contentView
        view.layer.opacity = 0.1
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: {
            view.layer.opacity = 1
        }, completion: nil)
    }

}
