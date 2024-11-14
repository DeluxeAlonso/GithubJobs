//
//  ExpandCollapseControlDisclosureStyle.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import SwiftUI

struct ExpandCollapseControlDisclosureStyle: DisclosureGroupStyle {

    let styleConfiguration: ExpandCollapseControlConfiguration

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack(alignment: .center) {
                configuration.label
                Spacer()
                Image(systemName: configuration.isExpanded ? styleConfiguration.expandedIconName : styleConfiguration.collapsedIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24.0, height: 24.0)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            }
        }
        if configuration.isExpanded {
            configuration.content
        }
    }

}
