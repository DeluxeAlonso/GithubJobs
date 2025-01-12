//
//  BaseView.swift
//  GithubJobs
//
//  Created by Alonso on 26/12/24.
//

import SwiftUI

protocol BaseView: LoadableView, ErrorPlaceholderView {
    associatedtype MainContent: View

    associatedtype PopulatedContent: View

    var populated: PopulatedContent { get }

    var content: MainContent { get }
}
