import RxSwift

/// Retrieve list of locations from outside source
/// - Requires: `RxSwift`, `Async`
final class LocationsListUseCase {
    
    // MARK: Dependencies
    private let interactor: LocationsListInteractor
    
    // MARK: - Life cycle
    
    init(interactor: LocationsListInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension LocationsListUseCase {
    func getCarListForLocation(locationModel: LocationModel) -> Observable<LocationsListStatus> {
        guard let positionTuple = getTwoPositionsFromLocation(locationModel: locationModel) else {
            assertionFailure("Bounds array did not contain 2 or more elements")
            return Observable.just(LocationsListStatus.error)
        }
        return interactor.getListOfCarsForLocation(
            position1: positionTuple.0,
            position2: positionTuple.1
        )
            .map { (result: Async<Any>) -> LocationsListStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let model = LocationCarModel.parse(from: data) else {
                        return .error
                    }
                    return .success(model)
                case .error:
                    return .error
                }
        }
    }
}

private extension LocationsListUseCase {
    func getTwoPositionsFromLocation(locationModel: LocationModel) -> (Position, Position)? {
        guard let position1 = locationModel.bounds.first else {
            return nil
        }
        guard let position2 = locationModel.bounds[safe: .tail(0)] else {
            return nil
        }
        return (position1, position2)
    }
}
