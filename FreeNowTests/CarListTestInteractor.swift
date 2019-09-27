import RxSwift
@testable import FreeNow

final class LocationListTestInteractor: LocationsListInteractor {
    
    // MARK: Dependencies
    
    
    // MARK: - Life cycle
}

extension LocationListTestInteractor {
    
    // MARK: - Internal
    func getListOfCarsForLocation(position1: Position, position2: Position) -> Observable<Async<Any>> {
        let coordinate = ["longitude": 23, "latitude":53]
        let dictionary: [String : Any] = [
            "id": 5,
            "coordinate": coordinate,
            "fleetType": "taxi",
        ]
        let poiDict = ["poiList": [dictionary]]
        return Observable.just(poiDict).async()
    }
}
