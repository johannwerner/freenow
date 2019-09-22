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

    func showCarList(
        model: LocationCarModel,
        locationModel: LocationModel,
        animated: Bool
    ) {        
        carListCoordinator.showCarList(
            models: model.poiList.convert(),
            locationName: locationModel.name,
            animated: animated
        )
    }
}

// MARK: - Navigation To CarList
private extension LocationsListCoordinator {
    var carListConfigurator: CarListConfigurator {
        CarListConfigurator(carListInteractor: CarListInteractorApi())
    }
    
    var carListCoordinator: CarListCoordinator {
        CarListCoordinator(
            navigationController: navigationController,
            configurator: carListConfigurator
        )
    }
}

// MARK: - Convert
private extension NonEmptyArray where Iterator.Element == LocationCarModel.PointOfInterest {
    func convert() -> NonEmptyArray<CarModel> {
        map { model -> CarModel in
            CarModel(locationCarModel: model)
        }
    }
}

// MARK: - CarModel
private extension CarModel {
    init(locationCarModel: LocationCarModel.PointOfInterest) {
        self = CarModel(
            licensePlate: locationCarModel.licensePlate,
            id: locationCarModel.id,
            model: locationCarModel.model,
            fuel: locationCarModel.fuel,
            position: locationCarModel.coordinate
        )
    }
}

// MARK: - Navigation to Error View

extension LocationsListCoordinator {
    func showError(
        animated: Bool
    ) {
        let configurator = ErrorModuleConfigurator(errorModuleInteractor: ErrorModuleInteractorApi())
        let coordinator = ErrorModuleCoordinator(navigationController: navigationController, configurator: configurator)
        coordinator.showError(animated: animated)
    }
}
