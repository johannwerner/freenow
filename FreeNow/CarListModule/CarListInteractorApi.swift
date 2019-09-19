import RxSwift
import RxAlamofire

/// Get a list of cars from outside source
/// - Requires: `RxSwift`, `Async`, `RxAlamofire`
final class CarListInteractorApi: CarListInteractor {
    
    // MARK: - Properties
    
    // MARK: Dependencies
    
    // MARK: - Life cycle
}

extension CarListInteractorApi {
    // MARK: - Internal
    
    func getListOfCarsForLocation(location: String) -> Observable<Async<Any>> {
        RxAlamofire
            .requestJSON(
                .get,
                 url(location),
                 parameters: nil
            )
            .flatMap { (response, json) -> Observable<Any> in
                return Observable.just(json)
            }.async()
    }
}

private extension CarListInteractorApi {
    func url(_ location: String) -> String {
        String(format: CarListConstants.carListUrl, location)
    }
}
