//
//  CharacterSet+Filtering.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

extension CharacterSet {

    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()

}
