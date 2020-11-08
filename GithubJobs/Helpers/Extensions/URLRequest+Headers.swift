//
//  URLRequest+Headers.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

extension URLRequest {

    mutating func setJSONContentType() {
        setValue("application/json; charset=utf-8",
                 forHTTPHeaderField: "Content-Type")
    }

    mutating func setHeader(for httpHeaderField: String, with value: String) {
        setValue(value, forHTTPHeaderField: httpHeaderField)
    }

}
