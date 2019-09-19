import Foundation

extension String {
    ///tableName is CarAppLocalizable,
    ///missing string will be displayed when no value exists.
    func localizedString(_ comment: String = "") -> String {
        NSLocalizedString(
            self,
            tableName: "FreeNow",
            value: "missing string",
            comment: comment
        )
    }
}
