import RxCocoa
import RxSwift

/// - Requires: `RxSwift`, , `RxCocoa`
/// - Note: A view model can refer to one or more use cases.
final class MapViewViewModel {

    // MARK: - Properties
    var positions: NonEmptyArray<Position>

    // MARK: MvRx
    let viewEffect = PublishRelay<MapViewViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: MapViewCoordinator
    private let useCase: MapViewUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(coordinator: MapViewCoordinator,
         configurator: MapViewConfigurator,
         positions: NonEmptyArray<Position>
        ) {
        self.coordinator = coordinator
        let interactor = configurator.mapViewInteractor
        self.useCase = MapViewUseCase(interactor: interactor)
        self.positions = positions
        
        observeViewEffect()
    }
}

// MARK: - Public functions

extension MapViewViewModel {

    func bind(to viewAction: PublishRelay<MapViewViewAction>) {
        viewAction
            .asObservable()
            .debounce(DispatchTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] viewAction in
                switch viewAction {
                case .mapBoundsUpdated(let mapBounds):
                    self.showCarList(position1: mapBounds.position1, position2: mapBounds.position2)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension MapViewViewModel {

    func showCarList(position1: Position, position2: Position) {
            useCase.getCarListForLocation(position1: position1, position2: position2)
                 .subscribe(onNext: { [unowned self] status in
                     switch status {
                     case .loading:
                        self.viewEffect.accept(.loading)
                     case .error:
                        self.viewEffect.accept(.error)
                        self.coordinator.showError(animated: true)
                     case .success(let positions):
                        self.positions = positions
                        self.viewEffect.accept(.success)
                     }
                 })
                 .disposed(by: disposeBag)
        }
}

// MARK: - Rx

private extension MapViewViewModel {
    
    /// - Note: Privately observing view effects in the view model is meant to make the association between a specific effect and certain view states easier.
    func observeViewEffect() {
            viewEffect
                .asObservable()
                .subscribe(onNext: { effect in
                    switch effect {
                    case .success: break
                    case .loading: break
                    case   .error: break  
                    }
                })
                .disposed(by: disposeBag)
        }
    }
