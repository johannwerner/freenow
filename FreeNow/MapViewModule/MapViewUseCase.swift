import RxSwift
/// - Requires: `RxSwift`
final class MapViewUseCase {
    
    // MARK: Dependencies
    private let interactor: MapViewInteractor
    
    // MARK: - Life cycle
    
    init(interactor: MapViewInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension MapViewUseCase {
    func getCarListForLocation(position1: Position, position2: Position) -> Observable<MapListStatus> {
        interactor.getListOfCarsForLocation(position1: position1, position2: position2)
            .map { (result: Async<Any>) -> MapListStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let model = MapCarModel.parse(from: data) else {
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
