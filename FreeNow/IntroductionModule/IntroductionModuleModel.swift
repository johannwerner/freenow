/// Operation status enum for  IntroductionModule.
enum  IntroductionModuleStatus {
    case loading
    case error
    case success([IntroductionLocationModel])
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
    static let locationsUrl = "https://car2go.now.sh/locations"
}

struct IntroductionLocationModel: Codable {
    var name: String
}
