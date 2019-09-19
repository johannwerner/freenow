import RxSwift
import Foundation

/// Retrieve a list of cars from outside source
/// - Requires: `RxSwift`, `Async`
final class CarListUseCase {
    
    // MARK: - Properties
    var locationName: String
    // MARK: Dependencies
    private let interactor: CarListInteractor
    
    // MARK: - Life cycle
    
    init(
        interactor: CarListInteractor,
        locationName: String = ""
        ) {
        self.interactor = interactor
        self.locationName = locationName
    }
}

// MARK: - Public functions

extension CarListUseCase {
    
    func getCarListForLocation() -> Observable<CarListStatus> {
        interactor.getListOfCarsForLocation(location: locationName)
            .map { (result: Async<Any>) -> CarListStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):                    
                    guard let listOfArray = data as? Array<Dictionary<String, Any>>  else {
                        return .error
                    }
                    let listOfCarModels = listOfArray.compactMap({ dict -> CarModel? in
                        CarModel.parse(from: dict)
                    })
                    guard let nonEmpty = listOfCarModels.convertToNonEmptyArray() else {
                        return .error
                    }
                    return .success(nonEmpty)
                case .error:
                    return .error
                }
        }
    }
}
