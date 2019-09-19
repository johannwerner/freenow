//
//  Array+CarApp.swift
//  CarApp
//
//  Created by Johann Werner on 16.08.19.
//  Copyright © 2019 Johann Werner. All rights reserved.
//

import Foundation

extension Array {
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension NonEmptyArray {
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    /// Converts array to NonEmptyArray
    /// Returns nil if array is empty
    func convertToNonEmptyArray() -> NonEmptyArray<Element>? {
        guard let first = self.first else {
            debugPrint("array is empty")
            return nil
        }
        var nonEmpty = NonEmptyArray(first)
        var newArray = self
        newArray.remove(at: 0)
        newArray.forEach { element in
            nonEmpty.append(element)
        }
        return nonEmpty
    }
}
