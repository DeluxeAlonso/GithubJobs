//
//  RangeReplaceableCollection+Extensions.swift
//  GithubJobs
//
//  Created by Alonso on 18/02/25.
//

import Foundation

extension RangeReplaceableCollection {

    mutating func removeLast(while predicate: (Element) throws -> Bool) rethrows {
        guard let index = try indices.reversed().first(where: { try !predicate(self[$0]) }) else {
            removeAll()
            return
        }
        removeSubrange(self.index(after: index)...)
    }

}
