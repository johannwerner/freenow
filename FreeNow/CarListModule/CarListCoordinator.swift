import UIKit

/// Show the available vehicels for a speficic location
/// - Requires: `RxSwift`
final class CarListCoordinator {

    // MARK: Dependencies
    private let navigationController: UINavigationController
    private let configurator: CarListConfigurator
    
    // MARK: Tooling
    
    // MARK: - Life cycle
    
    init(
    navigationController: UINavigationController, 
    configurator: CarListConfigurator
    ) {
        self.navigationController = navigationController
        self.configurator = configurator
    }
}

// MARK: - Navigation IN

extension CarListCoordinator {
    
    func showCarList(
        models: NonEmptyArray<CarModel>,
        locationName: String,
        animated: Bool
        ) {
        let model = CarListModel(
            locationName: locationName,
            carModels: models
        )
        let viewModel = CarListViewModel(
            coordinator: self,
            configurator: configurator,
            model: model
        )
        let viewController = CarListViewController(viewModel: viewModel)
        navigationController.pushViewController(
            viewController,
            animated: animated
        )
    }
}

// MARK: - Navigation OUT

extension CarListCoordinator {
    func showMapView(
        position: Position,
        model: CarListModel,
        animated: Bool
        ) {
        mapViewcoordinator.showMapView(
            position: position,
            allPositions: model.convert(),
            animated: animated
        )
    }
}

private extension CarListCoordinator {
    var mapViewConfigurator: MapViewConfigurator { MapViewConfigurator(mapViewInteractor: MapViewInteractorApi())
    }
    
    var mapViewcoordinator: MapViewCoordinator {
        MapViewCoordinator(
          navigationController: navigationController,
          configurator: mapViewConfigurator
      )
    }
}

private extension CarListModel {
    func convert() -> [Position] {
        carModels.map { carModel -> Position in
            carModel.position
        }
    }
}
