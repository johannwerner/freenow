import RxSwift
protocol IntroductionModuleInteractor {
    func getListOfLocations() -> Observable<Async<Any>>
}
