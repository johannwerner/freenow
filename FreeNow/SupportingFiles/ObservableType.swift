import RxSwift

extension ObservableType {
    public func async() -> Observable<Async<Element>> {
        map {
            Async.success($0)
        }
        .catchError { error in
            Observable.just(Async.error(error))
        }
        .do(onCompleted: {
            print()
        })
        .startWith(Async.loading)
    }
}
