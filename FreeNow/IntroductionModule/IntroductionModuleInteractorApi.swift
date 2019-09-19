import RxSwift
import RxAlamofire
///
/// - Requires:
final class IntroductionModuleInteractorApi: IntroductionModuleInteractor {}

extension IntroductionModuleInteractorApi {
    // MARK: - Internal
    
    func getListOfLocations() -> Observable<Async<Any>> {
        RxAlamofire
            .requestJSON(
                .get,
                 url,
                 parameters: nil
            )
            .flatMap { (response, json) -> Observable<Any> in
                return Observable.just(json)
            }.async()
    }
}

private extension IntroductionModuleInteractorApi {
    var url: String {
        IntroductionConstants.locationsUrl
    }
}
