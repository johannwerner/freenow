//
//  LocationCarModel.swift
//  CarApp
//
//  Created by Johann Werner on 10.09.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import Foundation

struct LocationCarModel: Codable {
    var poiList: [PointOfInterest]
    struct PointOfInterest: Codable {
        var id: Int
        var coordinate: Position
        var fleetType: String
        var licensePlate = "HCD837EC"
        var model: String = "Tesla S"
        var fuel: Double = 0.9
    }
}
