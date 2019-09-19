import Foundation

struct CarModel: Codable, Equatable {
    static func == (lhs: CarModel, rhs: CarModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var numberPlate: String
    var id: Int
    var model: String
    var fuel: Double
    var position: Position
}

// MARK: - Public
extension CarModel {
    var fuelString: String {
        fuelStringImplementation
    }
}

// MARK: - Private
private extension CarModel {
    var fuelStringImplementation: String {
        if fuel == 0.0 {
            return "car_list_item_tank_empty".localizedString()
        }
        let fuelDouble = fuel*100
        let finalString = String(format: "car_list_item_tank_status".localizedString(), fuelDouble)
        return finalString
    }
}
