/// Operation status enum for  IntroductionModule.
enum IntroductionModuleStatus {
    case loading
    case error
    case success(NonEmptyArray<IntroductionLocationModel>)
}

/// View effect enum for  IntroductionModule.
enum IntroductionModuleViewEffect {
    case success
    case loading
    case error
}

/// View action enum for  IntroductionModule.
enum IntroductionModuleViewAction {
    case primaryButtonPressed
}

struct IntroductionConstants {
    static let titleLabelText = "Johann Werner"
}

struct IntroductionLocationModel: Codable {
    var name: String
    /// Bounds should always have two or more items in the array otherwise through error.
    /// IntroductionModuleUseCase ensures bounds will two or more items otherwise the user will see the error screen and not the location screen.
    var bounds: NonEmptyArray<Position>
    
    enum CodingKeys: String, CodingKey {
        case bounds
        case name
    }
    
    // MARK: - Life Cycle
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let array = try container.decode([Position].self, forKey: .bounds)
        let name = try container.decode(String.self, forKey: .name)
        guard let bounds = array.convertToNonEmptyArray() else {
            throw DecodeError.arrayIsEmptyError
        }
        self.bounds = bounds
        self.name = name
    }
}
