//
//  HostingController.swift
//  GithubJobs
//
//  Created by Alonso on 29/12/24.
//

import Combine
import SwiftUI

final class HostingController<Content>: UIHostingController<Content> where Content: View {

    private let configuration: HostingConfiguration

    private var cancellables: Set<AnyCancellable> = []

    init(rootView: Content, configuration: HostingConfiguration) {
        self.configuration = configuration
        super.init(rootView: rootView)

        configuration
            .$title
            .sink { [weak self] title in
                guard let self else { return }
                self.title = title
            }.store(in: &cancellables)
    }

    @MainActor
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
