//
//  String+CarApp.swift
//  CarApp
//
//  Created by Johann Werner on 16.08.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import Foundation

extension String {
    ///tableName is CarAppLocalizable,
    ///missing string will be displayed when no value exists.
    func localizedString(_ comment: String = "") -> String {
        NSLocalizedString(
            self,
            tableName: "CarAppLocalizable",
            value: "missing string",
            comment: comment
        )
    }
}
