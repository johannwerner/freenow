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
                    let positions = model.convert()
                    return .success(positions)
                case .error:
                    return .error
                }
        }
    }
}

private extension MapCarModel {
    func convert() -> NonEmptyArray<Position> {
        poiList.map { carModel -> Position in
            carModel.coordinate
        }
    }
}
