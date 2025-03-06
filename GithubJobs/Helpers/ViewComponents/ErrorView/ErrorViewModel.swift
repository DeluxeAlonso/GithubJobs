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
    var imageSize: CGSize { get }

}

struct ErrorViewModel: ErrorViewModelProtocol {

    let title: String?
    let subtitles: [String]

    var imageSize: CGSize {
        CGSize(width: 64.0, height: 64.0)
    }

    init(title: String? = nil, subtitles: [String] = []) {
        self.title = title
        self.subtitles = subtitles
    }

}
