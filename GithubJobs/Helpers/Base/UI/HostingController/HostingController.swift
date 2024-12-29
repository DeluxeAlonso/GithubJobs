//
//  HostingController.swift
//  GithubJobs
//
//  Created by Alonso on 29/12/24.
//

import SwiftUI

class HostingController<Content>: UIHostingController<Content> where Content: View {

    private let configuration: HostingConfiguration

    init(rootView: Content, configuration: HostingConfiguration) {
        self.configuration = configuration
        super.init(rootView: rootView)
    }

    @MainActor
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
