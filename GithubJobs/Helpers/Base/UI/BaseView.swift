//
//  BaseView.swift
//  GithubJobs
//
//  Created by Alonso on 26/12/24.
//

import SwiftUI

protocol BaseView: View {
    associatedtype LoadingContent: View
    associatedtype PopulatedContent: View
    associatedtype ErroContent: View

    var loading: LoadingContent { get }
    var populated: PopulatedView { get }
    var error: ErroContent { get }
}
