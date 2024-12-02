//
//  FAQsContent.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import SwiftUI

struct FAQsContent<ViewModel: FAQsViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            ForEach(viewModel.items, id: \.title) {
                FAQsItemContent(viewModel: $0)
            }
        }
    }
}
