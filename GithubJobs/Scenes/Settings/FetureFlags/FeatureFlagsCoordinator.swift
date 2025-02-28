//
//  ColorSelectionCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import UIKit
import SwiftUI

final class FeatureFlagsCoordinator: BaseCoordinator {
    
    override func build() -> UIViewController {
        let hostingConfiguration = HostingConfiguration()

        let viewModel = makeViewModel(hostingConfiguration: hostingConfiguration)
        let view = FeatureFlagsContent(viewModel: viewModel)
        return HostingController(rootView: view, configuration: hostingConfiguration)
    }

    private func makeInteractort() -> FeatureFlagsInteractorProtocol {
        FeatureFlagsInteractor(featureFlagsManager: FeatureFlagsManager.shared)
    }

    private func makeViewModel(hostingConfiguration: HostingConfiguration) -> some FeatureFlagsViewModelProtocol {
        FeatureFlagsViewModel(interactor: makeInteractort(),
                              hostingConfiguration: hostingConfiguration)
    }

}
