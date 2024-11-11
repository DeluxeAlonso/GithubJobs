//
//  ExpandCollapseControlDisclosureStyle.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import SwiftUI

struct ExpandCollapseControlDisclosureStyle: DisclosureGroupStyle {

    let expandCollapseControlConfiguration: ExpandCollapseControlConfiguration

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            configuration.label
            Spacer()
            Image(uiImage: .checkmark)
                .resizable()
                .renderingMode(.template)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                configuration.isExpanded.toggle()
            }
        }
        if configuration.isExpanded {
            configuration.content
        }
    }

}
