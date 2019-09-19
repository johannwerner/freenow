import RxSwift
import RxAlamofire

/// Retrieve list of Locations from outside source
/// - Requires: `RxSwift`, `Async`, `RxAlamofire`

final class LocationsListInteractorApi: LocationsListInteractor {
   
    // MARK: - Properties
    
    // MARK: Dependencies
    
    // MARK: - Life cycle
}

extension LocationsListInteractorApi {
    // MARK: - Internal
    
    func getListOfCarsForLocation(position1: Position, position2: Position) -> Observable<Async<Any>> {
        RxAlamofire
            .requestJSON(
                .get,
                 url(position1: position1, position2: position2),
                 parameters: nil
            )
            .flatMap { (response, json) -> Observable<Any> in
                return Observable.just(json)
            }.async()
    }
}

private extension LocationsListInteractorApi {
    func url(position1: Position, position2: Position) -> String {
        String(format: LocationListConstants.carListUrl, position1.latitude, position1.longitude, position2.latitude, position2.longitude)
    }
}

