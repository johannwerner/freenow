import UIKit

/// Show the available locations 
/// - Requires: `UIKit`
final class LocationsListCoordinator {
    
    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: LocationsListConfigurator
    
    // MARK: Tooling
  
    // MARK: - Life cycle
    
    init(
        navigationController: UINavigationController,
        configurator: LocationsListConfigurator
        ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension LocationsListCoordinator {
    
    func showLocationList(models: NonEmptyArray<LocationModel>, animated: Bool) {
        let viewModel = LocationsListViewModel(
            coordinator: self,
            configurator: configurator, models: models
        )
        let viewController = LocationsListViewController(viewModel: viewModel)
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
}

// MARK: - Navigation OUT

extension LocationsListCoordinator {
}
