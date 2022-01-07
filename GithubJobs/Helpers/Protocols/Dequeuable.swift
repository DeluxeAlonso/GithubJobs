//
//  Dequeuable.swift
//  GithubJobs
//
//  Created by Alonso on 11/8/20.
//

import UIKit

protocol Dequeuable {

    static var dequeueIdentifier: String { get }

}

extension Dequeuable where Self: UIView {

    static var dequeueIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: Dequeuable { }
