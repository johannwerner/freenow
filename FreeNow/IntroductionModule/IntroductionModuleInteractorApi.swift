import RxSwift
import RxAlamofire
///
/// - Requires:
final class IntroductionModuleInteractorApi: IntroductionModuleInteractor {}

extension IntroductionModuleInteractorApi {
    // MARK: - Internal
    
    func getListOfLocations() -> Observable<Async<Any>> {
    let bounds = [
        ["latitude": 53.694865, "longitude": 9.757589],
        ["latitude": 53.394655, "longitude": 10.099891],
        ]
       let dictionary: [String : Any] = [
           "name": "Hamburg",
           "bounds": bounds
       ]
       return Observable.just([dictionary]).async()
    }
}
