//
//  ColorSelectionViewModel.swift
//  GithubJobs
//
//  Created by Alonso on 27/10/24.
//

import Combine

@MainActor
protocol FeatureFlagsViewModelProtocol: ObservableObject {

    var toggles: [FeatureFlagToggleViewModel] { get }

    func load() async

}

final class FeatureFlagsViewModel: FeatureFlagsViewModelProtocol {

    @Published var toggles: [FeatureFlagToggleViewModel] = []

    let featureFlagsManager: FeatureFlagsManagerProtocol
    let interactor: FeatureFlagsInteractorProtocol

    init(featureFlagsManager: FeatureFlagsManagerProtocol,
         interactor: FeatureFlagsInteractorProtocol) {
        self.featureFlagsManager = featureFlagsManager
        self.interactor = interactor
    }

    func load() async {
        let flags = await featureFlagsManager.allFlags
        self.toggles = flags.map {
            FeatureFlagToggleViewModel($0) { [weak self] identifier, value in
                self?.updateFeatureFlag(identifier: identifier, value: value)
            }
        }
    }

    private func updateFeatureFlag(identifier: String, value: Bool) {
        Task {
            await featureFlagsManager.updateFlag(identifier: identifier, value: value)
        }
    }

}

// MARK: - Toggle

@MainActor
protocol FeatureFlagToggleViewModelProtocol: ObservableObject {

    var identifier: String { get }
    var title: String { get }
    var value: Bool { get set }

}

final class FeatureFlagToggleViewModel: FeatureFlagToggleViewModelProtocol {

    let identifier: String
    let title: String
    @Published var value: Bool

    private let onTapHandler: OnTapHandler?
    typealias OnTapHandler = (String, Bool) -> Void

    private var cancellables: Set<AnyCancellable> = []

    init(_ featureFlag: FeatureFlagProtocol, onTapHandler: OnTapHandler? = nil) {
        self.identifier = featureFlag.identifier
        self.title = featureFlag.title
        self.value = featureFlag.value
        self.onTapHandler = onTapHandler

        setupBindables()
    }

    private func setupBindables() {
        $value
            .dropFirst()
            .sink { [weak self] value in
                guard let self else { return }
                self.onTapHandler?(self.identifier, value)
            }
            .store(in: &cancellables)
    }

}
