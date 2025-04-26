import Combine
import UIKit

/**
 * SettingsViewModelProtocol defines the interface for the Settings screen view model.
 *
 * This protocol separates the presentation logic from the view controller,
 * providing data and handling user interactions for the Settings screen.
 * It manages the display of settings sections and items, and coordinates
 * navigation requests through a coordinator.
 */
@MainActor
protocol SettingsViewModelProtocol {

    /// Publisher for section models that represent the structure of the settings screen.
    /// The view subscribes to this publisher to receive updates when settings data changes.
    var sectionModelsPublisher: Published<[SettingsSection]>.Publisher { get }

    /// Subject that emits navigation events when a settings option requires navigation.
    /// The coordinator observes this subject to respond to navigation requests.
    var didUpdateNavigation: PassthroughSubject<SettingsNavigation, Never> { get }

    /**
     * Asynchronously loads settings items from the data source.
     * This method populates the settings sections with appropriate items
     * based on current application state and user preferences.
     */
    func loadItems() async

    /**
     * Returns the localized title for the settings screen.
     *
     * - Returns: A string representing the screen title, or nil if a default title should be used.
     */
    func screenTitle() -> String?

    /**
     * Handles the selection of a settings item at the specified index.
     * This typically triggers navigation or performs an action based on the selected item.
     *
     * - Parameter index: The index of the selected item within its section.
     * - Parameter section: The index of the section containing the selected item.
     */
    func selectItem(at index: Int, and section: Int)
}

/**
 * SettingsCoordinatorProtocol defines the navigation responsibilities for the Settings flow.
 *
 * Following the Coordinator pattern, this protocol abstracts navigation logic from the view model,
 * allowing the Settings flow to be managed independently of its presentation.
 * The coordinator responds to navigation requests and manages the presentation of new screens.
 */
@MainActor
protocol SettingsCoordinatorProtocol: AnyObject {

    /**
     * Initiates navigation to a new screen based on the specified navigation type.
     *
     * - Parameter navigation: The type of navigation to perform, defining the destination
     *   and any parameters needed for the navigation.
     */
    func startNavigation(for navigation: SettingsNavigation)

    /**
     * Dismisses the current settings screen and returns to the previous screen.
     * This method is typically called when the user completes or cancels the settings flow.
     */
    func dismiss()
}

/**
 * SettingsInteractorProtocol defines the interface for retrieving application settings data.
 *
 * This protocol abstracts the business logic and data access for settings-related operations,
 * providing a clean separation between the data layer and presentation layer.
 * The interactor is responsible for fetching current settings values from the appropriate data sources.
 */
protocol SettingsInteractorProtocol: Sendable {

    /**
     * Retrieves the current value of a feature flag.
     *
     * - Parameter identifier: The identifier of the feature flag to check.
     * - Returns: A boolean indicating whether the feature is enabled.
     */
    func getFeatureFlagValue(for identifier: FeatureFlagIdentifier) async -> Bool

    /**
     * Retrieves the current theme setting for the application.
     *
     * - Returns: The currently selected application theme.
     */
    func getCurrentTheme() async -> Theme
}
