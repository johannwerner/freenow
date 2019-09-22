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
    /// Converts array to NonEmptyArray.
    /// Returns nil if array is empty.
    func convertToNonEmptyArray() -> NonEmptyArray<Element>? {
        guard let first = self.first else {
            debugPrint("array is empty")
            return nil
        }
        var newArray = self
        newArray.remove(at: 0)
        return NonEmptyArray(first, newArray)
    }
    
    /// Converts array to NonEmptyArray.
    /// Crashes if array is empty.
    func forceToNonEmptyArray() -> NonEmptyArray<Element> {
        guard let nonEmpty = self.convertToNonEmptyArray() else {
            fatalError("array is empty")
        }
        return nonEmpty
    }
}
