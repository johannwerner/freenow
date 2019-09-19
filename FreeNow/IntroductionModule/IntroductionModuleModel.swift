/// Operation status enum for  IntroductionModule.
enum  IntroductionModuleStatus {
    case loading
    case error
    case success(NonEmptyArray<IntroductionLocationModel>)
}

/// View effect enum for  IntroductionModule.
enum  IntroductionModuleViewEffect {
    case success
    case loading
}

/// View action enum for  IntroductionModule.
enum  IntroductionModuleViewAction {
    case primaryButtonPressed
}

struct IntroductionConstants {
    static let titleLabelText = "Johann Werner"
}

struct IntroductionLocationModel: Codable {
    var name: String
    var bounds: [Position]
}
