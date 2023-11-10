//
//  TableViewDataSourcePrefetching.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class TableViewDataSourcePrefetching: NSObject, UITableViewDataSourcePrefetching {

    private let cellCount: Int
    private let needsPrefetch: Bool
    private let prefetchHandler: (() -> Void)

    init(cellCount: Int, needsPrefetch: Bool, prefetchHandler: @escaping (() -> Void)) {
        self.cellCount = cellCount
        self.needsPrefetch = needsPrefetch
        self.prefetchHandler = prefetchHandler
    }

    // MARK: - Private

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        indexPath.row >= cellCount - 1
    }

    private func prefetchIfNeeded(for indexPaths: [IndexPath]) {
        guard needsPrefetch else { return }
        if indexPaths.contains(where: isLoadingCell) {
            prefetchHandler()
        }
    }

    // MARK: - UITableViewDataSourcePrefetching

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        prefetchIfNeeded(for: indexPaths)
    }

}
