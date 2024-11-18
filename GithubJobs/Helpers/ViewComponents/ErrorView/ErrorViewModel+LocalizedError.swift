//
//  ErrorViewModel+LocalizedError.swift
//  GithubJobs
//
//  Created by Alonso on 15/11/24.
//

import Foundation

extension ErrorViewModel {

    init(localizedError: Error) {
        self.title = LocalizedStrings.errorTitle()
        self.subtitles = [localizedError.localizedDescription]
    }

}
