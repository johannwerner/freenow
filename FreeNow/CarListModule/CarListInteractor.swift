import RxSwift

/// Get list of cars from outside source
/// - Requires: `RxSwift`
protocol CarListInteractor {
    func getListOfCarsForLocation(location: String) -> Observable<Async<Any>>
}
