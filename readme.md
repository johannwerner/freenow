# FreeNow MVP Read Me

The app uses an MVVM-C Rx Architecture.
The reason why this architecture was selected is that MVVM separates business logic from view logic.
The coordinator part makes navigation between modules easy by allowing a few lines of code to show a new view. The coordinator also acts as the only entry point for the next module and if a module is deleted then one can simply remove the code in the navigation into the existing modules and the app still compiles.
In this architecture are also use cases which is where the business logic lives. This allows for easy testing and there is no need to create a ViewModel that requires a coordinator to use a navigation controller. 
I used a protocol for the network interactors so that I can create test interactors that subscribe to the protocol and inject the test interactors into the use case for testing purposes.
The View in the MVVM architecture sends all user events to the view model. The view model then takes appropriate action which could include calling a use case. The use case could fetch data from the network or a local database and then the view model sends any update to the view model.
Every module needs to have a view, view model, model, interactor and coordinator. Even when these are not necessary for smaller modules it is good to set it up in case the smaller modules need it in the future. The MapModule serves as an example here.
Data required for a screen is loaded from the previous module before the screen is shown to ensure that values can be non nil. The idea is that if there is an error that an error view is shown instead and not the intended screen. 

NonEmpty (https://github.com/pointfreeco/swift-nonempty) is a library for non empty collections (arrays, dictionaries, strings ect) and was used in this project as an experiment working with arrays that can't be empty.
The library was added via cocoapods but contained an error abort 6. Therefore was removed from the podfile and added by dragging the files into the project and this resolved the issue. Further investigation why this error is happening is still required.

- The design will be improved once collaboration over designs is done.
- Tests need be improved to handle "RxSwift subscribe" better.
- Initialize components in init rather than var.
- A decision was made to not handle errors in this version due to time constraints. The architecture is set up well to handle this in the future.
- A decision was made to use one localized string file rather than multiple localised strings per module.
