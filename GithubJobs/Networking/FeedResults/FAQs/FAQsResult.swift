//
//  FAQsResult.swift
//  GithubJobs
//
//  Created by Alonso on 2/12/24.
//

struct FAQsResult: Decodable {

    let faqs: [FAQResult]

}

extension FAQsResult {

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.faqs = try container.decode([FAQResult].self)
    }

}
