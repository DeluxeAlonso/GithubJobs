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
    var errorViewModel: ErrorViewModel? { get }

    var viewState: FeatureFlagsViewState { get }

    func load() async

}

final class FeatureFlagsViewModel: FeatureFlagsViewModelProtocol {

    @Published var toggles: [FeatureFlagToggleViewModel] = []
    @Published var errorViewModel: ErrorViewModel?

    @Published var viewState: FeatureFlagsViewState = .loading

    let interactor: FeatureFlagsInteractorProtocol

    init(interactor: FeatureFlagsInteractorProtocol) {
        self.interactor = interactor
    }

    func load() async {
        viewState = .loading
        switch await interactor.getAllFeatureFlags() {
        case .success(let flags):
            self.toggles = flags.map {
                FeatureFlagToggleViewModel($0) { [weak self] identifier, value in
                    self?.updateFeatureFlag(identifier: identifier, value: value)
                }
            }
            self.viewState = .populated
        case .failure(let error):
            self.errorViewModel = ErrorViewModel(localizedError: error)
            self.viewState = .error
        }

    }

    private func updateFeatureFlag(identifier: String, value: Bool) {
        Task {
            await interactor.updateFeatureFlag(identifier: identifier, value: value)
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
