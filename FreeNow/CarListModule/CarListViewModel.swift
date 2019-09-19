import RxCocoa
import RxSwift

/// - Requires: `RxSwift`, , `RxCocoa`
/// - Note: A view model can refer to one or more use cases.
final class CarListViewModel {
    // MARK: - Properties
    var model: CarListModel
    
    // MARK: MvRx
    let viewEffect = PublishRelay<CarListViewEffect>()
    
    // MARK: Dependencies
    private let coordinator: CarListCoordinator
    private let useCase: CarListUseCase
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(
         coordinator: CarListCoordinator,
         configurator: CarListConfigurator,
         model: CarListModel
        ) {
        self.coordinator = coordinator
        let interactor = configurator.carListInteractor
        self.useCase = CarListUseCase(interactor: interactor)
        self.model = model
        observeViewEffect()
    }
}

// MARK: - Public functions

extension CarListViewModel {
    
    var numberOfRows: Int {
        model.carModels.count
    }
    
    var locationName: String {
        model.locationName
    }
    
    func modelForIndexPath(index: Int) -> CarModel {
        if index == 0 {
           return model.carModels.first
        }
        guard let location = model.carModels[safe: .tail(index - 1)] else {
            assertionFailure("index out of bounds")
            return model.carModels.first
        }
        return location
    }
    
    func bind(to viewAction: PublishRelay<CarListViewAction>) {
        viewAction
            .asObservable()
            .subscribe(onNext: { [unowned self] viewAction in
                switch viewAction {
                case .selectedIndex(let index):
                    let model = self.modelForIndexPath(index: index)
                    self.coordinator.showMapView(
                        position: model.position,
                        animated: true
                    )
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Private functions

private extension CarListViewModel {
    
    func getListOfCarsForLocation() {
        useCase.getCarListForLocation()
            .subscribe(onNext: { [unowned self] status in
                switch status {
                case .loading:
                    break
                case .error:
                    break
                case .success(let listOfCars):
                    self.model.carModels = listOfCars
                    self.viewEffect.accept(.success)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Rx

private extension CarListViewModel {

    /// - Note: Privately observing view effects in the view model is meant to make the association between a specific effect and certain view states easier.
    func observeViewEffect() {
        viewEffect
            .asObservable()
            .subscribe(onNext: { effect in
                switch effect {
                case .success:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
