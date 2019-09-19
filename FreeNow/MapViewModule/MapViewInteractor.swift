import RxSwift
///
/// - Requires: `RxSwift`
protocol MapViewInteractor {
    func getListOfCarsForLocation(position1: Position, position2: Position) -> Observable<Async<Any>> 
}
