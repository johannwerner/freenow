import RxCocoa
import RxSwift

/// - Requires: `RxSwift`,  `RxCocoa`
/// - Note: A view model can refer to one or more use cases.
final class LocationsListViewModel {
    
    // MARK: - Properties
    private let listOfLocations: NonEmptyArray<LocationModel>
    
    // MARK: MvRx
    let viewEffect = PublishRelay<LocationsListViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: LocationsListCoordinator
    private let useCase: LocationsListUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()
    
    // MARK: - Life cycle
    
    init(coordinator: LocationsListCoordinator,
         configurator: LocationsListConfigurator,
         models: NonEmptyArray<LocationModel>) {
        self.coordinator = coordinator
        self.useCase = LocationsListUseCase(interactor: configurator.locationsListInteractor)
        self.listOfLocations = models
        observeViewEffect()
    }
}

// MARK: - Public functions

extension LocationsListViewModel {
    
    var numberOfRows: Int {
        listOfLocations.count
    }
    
    func modelForIndex(index: Int) -> LocationModel {
        if index == 0 {
           return listOfLocations.first
        }
        guard let location = listOfLocations[safe: .tail(index - 1)] else {
            assertionFailure("index out of bounds")
            return listOfLocations.first
        }
        return location
    }
    
    func bind(to viewAction: PublishRelay<LocationsListViewAction>) {
        viewAction
            .asObservable()
            .subscribe(onNext: { [unowned self] viewAction in
                switch viewAction {
                case .selectedIndex(atIndex: let index):
                    let locationModel = self.modelForIndex(index: index)
                    self.showCarList(locationModel: locationModel)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension LocationsListViewModel {

    func showCarList(locationModel: LocationModel) {
        useCase.getCarListForLocation(locationModel: locationModel)
             .subscribe(onNext: { [unowned self] status in
                 switch status {
                 case .loading:
                    self.viewEffect.accept(.loading)
                 case .error:
                    self.viewEffect.accept(.error)
                    self.coordinator.showError(animated: true)
                 case .success(let model):
                    self.viewEffect.accept(.success)
                    self.coordinator.showCarList(
                        model: model,
                        locationModel: locationModel,
                        animated: true
                    )
                 }
             })
             .disposed(by: disposeBag)
    }
}


// MARK: - Rx

private extension LocationsListViewModel {
    
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
