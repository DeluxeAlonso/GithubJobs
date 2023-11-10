//
//  String+Localized.swift
//  GithubJobs
//
//  Created by Alonso on 11/8/20.
//

import Foundation

extension String {

    func localized(bundle: Bundle = .main,
                   tableName: String = "Localizable",
                   comment: String = "") -> String {
        NSLocalizedString(self, tableName: tableName, value: self, comment: comment)
    }

}
