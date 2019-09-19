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
    func getCarListForLocation(location: String) -> Observable<LocationsListStatus> {
        interactor.getListOfCarsForLocation(location: location)
            .map { (result: Async<Any>) -> LocationsListStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let model = LocationCarModel.parse(from: data) else {
                        return .error
                    }
                    guard model.poiList.isEmpty == false else {
                        return .error
                    }
                    return .success(model)
                case .error:
                    return .error
                }
        }
    }
}
