//
//  Descriptable.swift
//  GithubJobs
//
//  Created by Alonso on 11/7/20.
//

import Foundation

protocol Descriptable {

    var description: String { get }

}

protocol ErrorDescriptable: Descriptable {}
