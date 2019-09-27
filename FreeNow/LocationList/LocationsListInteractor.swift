import RxSwift

/// Purpose of interactor is to retrieve list of Locations from outside source
/// - Requires: `RxSwift`
protocol LocationsListInteractor {
    func getListOfCarsForLocation(position1: Position, position2: Position) -> Observable<Async<Any>>
}
