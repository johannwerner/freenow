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
    
    func bind(to viewAction: PublishRelay<MapViewViewAction>) {}
}

// MARK: - Private functions

private extension MapViewViewModel {}

// MARK: - Rx

private extension MapViewViewModel {
    
    /// - Note: Privately observing view effects in the view model is meant to make the association between a specific effect and certain view states easier.
    func observeViewEffect() {}
}
