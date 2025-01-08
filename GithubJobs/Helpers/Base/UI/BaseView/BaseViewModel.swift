//
//  BaseViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 7/01/25.
//

import Foundation

protocol BaseViewModel: ObservableObject {

    var errorViewModel: ErrorViewModel? { get }

}
