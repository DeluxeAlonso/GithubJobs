//
//  UICollectionView+Register.swift
//  GithubJobs
//
//  Created by Alonso on 4/07/22.
//

import UIKit

extension UICollectionView {

    // MARK: - Register

    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let identifier = cellType.dequeueIdentifier
        register(cellType, forCellWithReuseIdentifier: identifier)
    }

    func register<T: UICollectionReusableView>(viewType: T.Type, kind: String) {
        register(viewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: kind)
    }

    // MARK: - Dequeuing

    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                          kind: String,
                                                          for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: kind,
                                                for: indexPath) as! T
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.dequeueIdentifier, for: indexPath) as! T
    }

}
