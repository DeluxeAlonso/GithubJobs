//
//  BaseView.swift
//  GithubJobs
//
//  Created by Alonso on 26/12/24.
//

import SwiftUI

protocol BaseView: View {
    associatedtype LoadingView: View
    associatedtype PopulatedView: View
    associatedtype ErrorView: View

    var loading: LoadingView { get }
    var populated: PopulatedView { get }
    var error: ErrorView { get }
}
