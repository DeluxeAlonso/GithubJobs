//
//  ColorSelectionContent.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import SwiftUI

struct ColorSelectionContent: View {
    @ObservedObject var viewModel: ColorSelectionViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// swiftlint:disable type_name
struct ColorSelectionContent_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectionContent(viewModel: ColorSelectionViewModel())
    }
}
