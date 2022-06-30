//
//  DataSourcePrefetching.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

protocol DataSourcePrefetching {

    var cellCount: Int { get }
    var needsPrefetch: Bool { get }
    var prefetchHandler: (() -> Void) { get }

    func isLoadingCell(for indexPath: IndexPath) -> Bool

}

extension DataSourcePrefetching {

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= cellCount - 1
    }

    func prefetchIfNeeded(for indexPaths: [IndexPath]) {
        guard needsPrefetch else { return }
        if indexPaths.contains(where: isLoadingCell) {
            prefetchHandler()
        }
    }

}
