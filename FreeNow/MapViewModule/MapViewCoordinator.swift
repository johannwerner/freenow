import UIKit

/// Show a map view with pinned locations
/// - Requires: `UIKit`
final class MapViewCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: MapViewConfigurator
    
    // MARK: Tooling

    // MARK: - Life cycle
    
    init(
        navigationController: UINavigationController,
        configurator: MapViewConfigurator
        ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension MapViewCoordinator {
    
    func showMapView(
        position: Position,
        allPositions: [Position],
        animated: Bool
        ) {
        let viewModel = MapViewViewModel(
            coordinator: self,
            configurator: configurator,
            positions: [position].convertToNonEmptyArray()!
        )
        let viewController = MapViewViewController(viewModel: viewModel)
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
}

// MARK: - Navigation OUT

extension MapViewCoordinator {
    func showError(
        animated: Bool
    ) {
        let configurator = ErrorModuleConfigurator(errorModuleInteractor: ErrorModuleInteractorApi())
        let coordinator = ErrorModuleCoordinator(navigationController: navigationController, configurator: configurator)
        coordinator.showError(animated: animated)
    }
}
