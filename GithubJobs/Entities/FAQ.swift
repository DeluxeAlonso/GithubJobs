//
//  FAQ.swift
//  GithubJobs
//
//  Created by Alonso on 2/12/24.
//

struct FAQ: Equatable {

    let id: String
    let title: String
    let descriptions: [String]

}

extension FAQ {

    init(_ faqResult: FAQResult) {
        self.id = faqResult.id
        self.title = faqResult.title
        self.descriptions = faqResult.descriptions
    }

}
