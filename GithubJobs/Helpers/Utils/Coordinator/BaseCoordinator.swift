//
//  BaseCoordinator.swift
//  GithubJobs
//
//  Created by Alonso on 22/02/25.
//

import UIKit

/**
 * Base implementation of the Coordinator protocol.
 *
 * BaseCoordinator provides a foundation for concrete coordinator implementations,
 * handling common coordinator tasks such as navigation controller management,
 * view controller presentation, and coordinator hierarchy maintenance.
 */
class BaseCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    /// Array to store and maintain references to child coordinators.
    var childCoordinators: [Coordinator] = []

    /// Reference to the parent coordinator in the hierarchy.
    var parentCoordinator: Coordinator?

    /// The main navigation controller used by this coordinator.
    var navigationController: UINavigationController

    /// Optional secondary navigation controller for detail views (e.g., in split view controllers).
    var detailNavigationController: UINavigationController?

    /// Flag indicating whether this coordinator should be automatically removed when its view controllers are dismissed.
    private(set) var shouldBeAutomaticallyFinished: Bool = false

    /// The main view controller managed by this coordinator.
    private var viewController: UIViewController?

    /// The presentation mode used for this coordinator.
    private var coordinatorMode: CoordinatorMode = .push

    /**
     * Initializes a new coordinator with a navigation controller.
     *
     * - Parameter navigationController: The navigation controller to be used by this coordinator
     */
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()

        setupNavigationControllerDelegate()
    }

    /**
     * Starts the coordinator's flow.
     * This is an abstract method that must be implemented by subclasses.
     */
    func start() {
        fatalError("Start method should be implemented")
    }

    /**
     * Creates and returns the main view controller for this coordinator.
     * This is an abstract method that must be implemented by subclasses.
     *
     * - Returns: The main view controller for this coordinator's flow.
     */
    func build() -> UIViewController {
        fatalError("Build method should be implemented")
    }

    /**
     * Starts the coordinator with a specific presentation mode.
     *
     * - Parameter coordinatorMode: How the coordinator's view controller will be presented.
     */
    func start(coordinatorMode: CoordinatorMode = .push) {
        let viewController = build()

        switch coordinatorMode {
        case .push:
            if let detailNavigationController {
                // If we have a detail navigation controller, push to it and show it
                detailNavigationController.pushViewController(viewController, animated: false)
                navigationController.showDetailViewController(detailNavigationController, sender: nil)
            } else {
                // Otherwise, use the main navigation controller
                detailNavigationController = navigationController
                navigationController.pushViewController(viewController, animated: true)
            }
            if navigationController.delegate == nil {
                navigationController.delegate = self
            }
        case .present(let presentingViewController, let configuration):
            // Push to our navigation controller and present it modally
            navigationController.pushViewController(viewController, animated: false)
            navigationController.modalPresentationStyle = configuration?.modalPresentationStyle ?? .automatic
            navigationController.transitioningDelegate = configuration?.transitioningDelegate
            presentingViewController.present(navigationController, animated: true, completion: {
                if self.navigationController.delegate == nil {
                    self.navigationController.delegate = self
                }
            })
        case .embed(let parentViewController, let containerView):
            // Embed as a child view controller
            guard parentCoordinator != nil else {
                assertionFailure("When starting on embed mode, parent coordinator is needed to perform appropiate deallocation.")
                return
            }
            if let containerView {
                parentViewController.add(asChildViewController: viewController,
                                         containerView: containerView)
            } else {
                parentViewController.add(asChildViewController: viewController)
            }
            self.viewController = viewController
            shouldBeAutomaticallyFinished = true
        }
        self.coordinatorMode = coordinatorMode
        self.viewController = viewController
    }

    /**
     * Dismisses the coordinator's view controller.
     */
    func dismiss() {
        dismiss(completion: nil)
    }

    /**
     * Dismisses the coordinator's view controller with an optional completion handler.
     *
     * - Parameter completion: Optional closure to be executed after dismissal.
     */
    func dismiss(completion: (() -> Void)? = nil) {
        switch coordinatorMode {
        case .push:
            // For push mode, pop the view controller
            navigationController.popViewController(animated: true)
            completion?()
        case .present:
            // For present mode, dismiss the presented view controller
            let presentedViewController = navigationController.topViewController
            presentedViewController?.dismiss(animated: true) { [weak self] in
                self?.unwrappedParentCoordinator.childDidFinish()
                completion?()
            }
        case .embed(let parentViewController, _):
            // For embed mode, remove the child view controller
            parentViewController.remove(asChildViewController: viewController)
            unwrappedParentCoordinator.childDidFinish(self)
            completion?()
        }
    }

    /// The navigation controller delegate used by this coordinator.
    var navigationControllerDelegate: UINavigationControllerDelegate? {
        self
    }

    /// Flag to force setting this coordinator as the navigation controller's delegate.
    var shouldForceDelegateOverride: Bool = false

    /**
     * Sets up the navigation controller delegate.
     * This is called during initialization to ensure proper navigation events are captured.
     */
    func setupNavigationControllerDelegate() {
        guard shouldForceDelegateOverride || navigationController.delegate == nil else {
            return
        }
        navigationController.delegate = navigationControllerDelegate
    }

    /**
     * UINavigationControllerDelegate method called when a view controller is shown.
     * Used to detect when a view controller is popped, to clean up coordinators as needed.
     */
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // We only intend to cover push/pop scenarios here. Present/dismissal handling should be done manually.
        let isBeingPresented = navigationController.isBeingPresented
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !isBeingPresented else {
            return
        }
        // Check whether our view controller array already contains that view controller.
        // If it does it means we're pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        unwrappedParentCoordinator.childDidFinish()
    }
}
