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
    var bounds: [Position]
}
