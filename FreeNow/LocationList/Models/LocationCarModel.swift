import Foundation

struct LocationCarModel: Codable {
    
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
        var id: Int
        var coordinate: Position
        var fleetType: String
        let numberPlate = "HCD837EC"
        let model: String = "Tesla S"
        let fuel: Double = 0.9
    }
}
