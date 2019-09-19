//
//  LocationModel.swift
//  CarApp
//
//  Created by Johann Werner on 16.08.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import Foundation

struct LocationModel: Codable {
    var name: String
    var bounds: [Position]
}
