import RxSwift
/// An introduction to the app
/// - Requires:
final class IntroductionModuleUseCase {
    
    // MARK: Dependencies
    private let interactor:  IntroductionModuleInteractor
    
    // MARK: - Life cycle
    
    init(interactor:  IntroductionModuleInteractor) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension IntroductionModuleUseCase {    
    func getListOfLocations() -> Observable<IntroductionModuleStatus> {
        interactor.getListOfLocations()
            .map { (result: Async<Any>) -> IntroductionModuleStatus in
                switch result {
                case .loading:
                    return .loading
                case .success(let data):
                    guard let listOfArray = data as? Array<Dictionary<String, Any>> else {
                        return .error
                    }
                    guard let nonEmptyArray = listOfArray.convert() else {
                        assertionFailure("array is  nil")
                        return .error
                    }
                    return .success(nonEmptyArray)
                case .error:
                    return .error
                }
        }
    }
}

private extension Array where Iterator.Element == Dictionary<String, Any> {
    func convert() -> NonEmptyArray<IntroductionLocationModel>? {
        compactMap({ dict -> IntroductionLocationModel? in
            guard let model = IntroductionLocationModel.parse(from: dict) else {
                assertionFailure("parse failed")
                return nil
            }
            guard model.bounds.count > 1 else {
                assertionFailure("bounds requires at least two positions")
                return nil
            }
            //Code in IntroductionModuleCoordinator relies on bounds never having an empty array <1>
            return model
            })
        .convertToNonEmptyArray()
    }
}
