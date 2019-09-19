import RxSwift

/// Purpose of interactor is to retrieve list of Locations from outside source
/// - Requires: `RxSwift`
protocol LocationsListInteractor {
    func getListOfCarsForLocation(location: String) -> Observable<Async<Any>> 
}
