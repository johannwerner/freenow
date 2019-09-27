
typealias MapBounds = (position1: Position, position2: Position)

/// Operation status enum for MapView.
enum MapListStatus {
    case loading
    case error
    case success(NonEmptyArray<Position>)
}

/// View effect enum for MapView.
enum MapViewViewEffect {
    case success
    case loading
    case error
}

/// View action enum for MapView.
enum MapViewViewAction {
    case mapBoundsUpdated(MapBounds)
}

struct MapConstants {
    static let carListUrl = "https://fake-poi-api.mytaxi.com/?p1Lat=%f&p1Lon=%f&p2Lat=%f&p2Lon=%f"
}

struct MapCarModel: Codable {
    
    // MARK: - Properties
    var poiList: NonEmpty<[PointOfInterest]>

    enum CodingKeys: String, CodingKey {
        case poiList
    }
    
    // MARK: - Life Cycle
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let array = try container.decode([PointOfInterest].self, forKey: .poiList)
        guard let nonEmpty = array.convertToNonEmptyArray() else {
            throw DecodeError.arrayIsEmptyError
        }
        poiList = nonEmpty
    }
    
    // MARK: - PointOfInterest
    struct PointOfInterest: Codable {
        var coordinate: Position
    }
}
