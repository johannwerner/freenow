import Foundation

struct LocationCarModel: Codable {
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
