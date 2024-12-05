//
//  FAQsResult.swift
//  GithubJobs
//
//  Created by Alonso on 2/12/24.
//

import Foundation

struct FAQsResult: Decodable {

    let faqs: [FAQ]

}

extension FAQsResult {

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.faqs = try container.decode([FAQ].self)
    }

}
