/// Operation status enum for MapView.
enum MapListStatus {
    case loading
    case error
    case success(MapCarModel)
}

/// View effect enum for MapView.
enum MapViewViewEffect {
    case someEffect
}

/// View action enum for MapView.
enum MapViewViewAction {
    case someAction
}

struct MapConstants {
    static let carListUrl = "https://fake-poi-api.mytaxi.com/?p1Lat=%f&p1Lon=%f&p2Lat=%f&p2Lon=%f"
}

struct MapCarModel: Codable {
    var poiList: [PointOfInterest]
    struct PointOfInterest: Codable {
        var id: Int
        var coordinate: Position
        var fleetType: String
        let numberPlate = "HCD837EC"
        let model: String = "Tesla S"
        let fuel: Double = 0.9
    }
}
