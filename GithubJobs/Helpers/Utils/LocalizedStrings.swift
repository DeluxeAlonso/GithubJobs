//
//  LocalizedStrings.swift
//  GithubJobs
//
//  Created by Alonso on 11/8/20.
//

protocol Localizable {

    var tableName: String { get }
    var localized: String { get }

}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {

    var localized: String {
        return rawValue.localized(tableName: tableName)
    }

}

enum LocalizedStrings: String, Localizable {

    case jobsTitle
    case emptyJobsTitle

    case relatedJobsTitle
    case emptyRelatedJobsTitle

    var tableName: String {
        return "Localizable"
    }

}

