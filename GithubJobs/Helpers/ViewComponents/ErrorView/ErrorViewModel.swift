//
//  ErrorViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 15/11/24.
//

import Foundation

protocol ErrorViewModelProtocol {

    var title: String? { get }
    var subtitles: [String] { get }

}

struct ErrorViewModel: ErrorViewModelProtocol {

    let title: String?
    let subtitles: [String]

    init(title: String? = nil, subtitles: [String] = []) {
        self.title = title
        self.subtitles = subtitles
    }

}
