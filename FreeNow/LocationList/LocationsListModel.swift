
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
    static let carListUrl = "https://fake-poi-api.mytaxi.com/?p2Lat=%d&p1Lon=%d&p1Lat=%d&p2Lon=%d"
}
