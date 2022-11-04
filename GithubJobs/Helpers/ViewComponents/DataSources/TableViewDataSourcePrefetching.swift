//
//  TableViewDataSourcePrefetching.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import UIKit

final class TableViewDataSourcePrefetching: NSObject, DataSourcePrefetching, UITableViewDataSourcePrefetching {

    private let cellCount: Int
    private let needsPrefetch: Bool
    private let prefetchHandler: (() -> Void)

    init(cellCount: Int, needsPrefetch: Bool, prefetchHandler: @escaping (() -> Void)) {
        self.cellCount = cellCount
        self.needsPrefetch = needsPrefetch
        self.prefetchHandler = prefetchHandler
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        prefetchIfNeeded(for: indexPaths)
    }

}
