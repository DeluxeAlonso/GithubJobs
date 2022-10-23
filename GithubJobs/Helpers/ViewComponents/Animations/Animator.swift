//
//  Animator.swift
//  GithubJobs
//
//  Created by Alonso on 20/10/22.
//

import UIKit

class Animator {

    class func fade(view: UIView, completion: ((Bool) -> Void)? = nil) {
        view.layer.opacity = 0.1
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: {
            view.layer.opacity = 1
        }, completion: completion)
    }

    class func fade(tableViewCell: UITableViewCell) {
        fade(view: tableViewCell.contentView)
    }

    class func fade(collectionViewCell: UICollectionViewCell) {
        fade(view: collectionViewCell.contentView)
    }

}
