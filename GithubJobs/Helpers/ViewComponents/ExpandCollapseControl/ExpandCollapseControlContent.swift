//
//  ExpandCollapseControlContent.swift
//  GithubJobs
//
//  Created by Alonso on 10/11/24.
//

import SwiftUI

struct ExpandCollapseControlContent<CollapsedContent: View, ExpandedContent: View>: View {

    @Binding private var isExpanded: Bool

    @ViewBuilder private var collapsedContent: () -> CollapsedContent
    @ViewBuilder private var expandedContent: () -> ExpandedContent

    private let configuration: ExpandCollapseControlConfiguration

    init(isExpanded: Binding<Bool>,
         collapsedContent: @escaping () -> CollapsedContent,
         expandedContent: @escaping () -> ExpandedContent,
         configuration: ExpandCollapseControlConfiguration) {
        _isExpanded = isExpanded
        self.collapsedContent = collapsedContent
        self.expandedContent = expandedContent
        self.configuration = configuration
    }

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded, content: expandedContent, label: collapsedContent)
            .disclosureGroupStyle(ExpandCollapseControlDisclosureStyle(styleConfiguration: configuration))
    }

}
