//
//  HostingController.swift
//  GithubJobs
//
//  Created by Alonso on 29/12/24.
//

import SwiftUI

class HostingController<Content>: UIHostingController<Content> where Content: View {

    override init(rootView: Content) {
        super.init(rootView: rootView)
    }

    @MainActor
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
