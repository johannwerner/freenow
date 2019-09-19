import RxCocoa

/// Operation status enum for CarList.
enum CarListStatus {
    case loading
    case error
    case success(NonEmptyArray<CarModel>)
}

/// View effect enum for CarList.
enum CarListViewEffect {
    case success
}

/// View action enum for CarList.
enum CarListViewAction {
    case selectedIndex(atIndex: Int)
}

struct CarListConstants {
    static let carListUrl = "https://car2go.now.sh/vehicles/%@"
}

struct CLMLComments {
    static let vehicleCellTitle = "Title of vehicle information in a list of vehicles."
}

struct CarListModel {
    var locationName: String
    var carModels: NonEmptyArray<CarModel>
}
