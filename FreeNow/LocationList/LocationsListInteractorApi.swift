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
    
    func getListOfCarsForLocation(location: String) -> Observable<Async<Any>> {
        RxAlamofire
            .requestJSON(
                .get,
                 url(location: location),
                 parameters: nil
            )
            .flatMap { (response, json) -> Observable<Any> in
                return Observable.just(json)
            }.async()
    }
}

private extension LocationsListInteractorApi {
    func url(location: String) -> String {
        String(format: LocationListConstants.carListUrl, location)
    }
}

