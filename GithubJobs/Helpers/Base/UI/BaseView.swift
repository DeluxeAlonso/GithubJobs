//
//  BaseView.swift
//  GithubJobs
//
//  Created by Alonso on 26/12/24.
//

import SwiftUI

protocol BaseView: View {
    associatedtype MainContent: View

    associatedtype LoadingContent: View
    associatedtype PopulatedContent: View
    associatedtype ErrorContent: View

    var loading: LoadingContent { get }
    var populated: PopulatedContent { get }
    var error: ErrorContent { get }

    var content: MainContent { get }
}
