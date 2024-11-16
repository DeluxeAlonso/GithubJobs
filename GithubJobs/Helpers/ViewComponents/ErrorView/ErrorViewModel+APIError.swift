//
//  ErrorViewModel+APIError.swift
//  GithubJobs
//
//  Created by Alonso on 15/11/24.
//

import Foundation

extension ErrorViewModel {

    init(apiError: APIError) {
        self.title = apiError.localizedDescription
        self.subtitles = []
    }

}
