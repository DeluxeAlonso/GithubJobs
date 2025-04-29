//
//  ExpandCollapseControlDisclosureStyle.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import SwiftUI

struct ExpandCollapseControlDisclosureStyle: DisclosureGroupStyle {

    let styleConfiguration: ExpandCollapseControlStyleConfiguration

    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: styleConfiguration.verticalSpacing) {
            HStack(alignment: .center, spacing: styleConfiguration.horizontalSpacing) {
                configuration.label
                Spacer()
                Image(systemName: configuration.isExpanded ? styleConfiguration.expandedIconName : styleConfiguration.collapsedIconName)
                    .scaledToFit()
                    .frame(width: styleConfiguration.iconSize.width, height: styleConfiguration.iconSize.height)
                    .padding(.trailing, styleConfiguration.iconTrailingPadding)
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

}
