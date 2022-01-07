//
//  UITableView+Register.swift
//  GithubJobs
//
//  Created by Alonso on 11/8/20.
//

import UIKit

extension UITableView {
    
    // MARK: - Cell Register
    
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let identifier = cellType.dequeueIdentifier
        register(cellType, forCellReuseIdentifier: identifier)
    }
    
    // MARK: - Nib Register
    
    func registerNib<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let identifier = cellType.dequeueIdentifier
        let nib = UINib(nibName: identifier, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    // MARK: - Dequeuing
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.dequeueIdentifier, for: indexPath) as! T
    }
    
}
