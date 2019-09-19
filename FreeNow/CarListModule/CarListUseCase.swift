import RxSwift
import Foundation

/// Retrieve a list of cars from outside source
/// - Requires: `RxSwift`, `Async`
final class CarListUseCase {
    
    // MARK: - Properties
    
    // MARK: Dependencies
    private let interactor: CarListInteractor
    
    // MARK: - Life cycle
    
    init(
        interactor: CarListInteractor
        ) {
        self.interactor = interactor
    }
}

// MARK: - Public functions

extension CarListUseCase {}
