
/// Operation status enum for LocationsList.
enum LocationsListStatus {
    case loading
    case error
    case success(LocationCarModel)
}


/// View effect enum for LocationsList.
enum LocationsListViewEffect {
    case success
    case loading
    case error
}

/// View action enum for LocationsList.
enum LocationsListViewAction {
    case selectedIndex(atIndex: Int)
}

struct LocationListConstants {
    static let carListUrl = "https://fake-poi-api.mytaxi.com/?p2Lat=53.394655&p1Lon=9.757589&p1Lat=53.694865&p2Lon=10.099891"
}
