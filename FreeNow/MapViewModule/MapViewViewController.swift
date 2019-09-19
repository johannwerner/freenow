import RxSwift
import RxCocoa
import MapKit

/// Show a map view
/// - Requires: `RxSwift`, `RxCocoa`
final class MapViewViewController: UIViewController {
    
    // MARK: Dependencies
    private let viewModel: MapViewViewModel
    
    // MARK: Rx
    private let viewAction = PublishRelay<MapViewViewAction>()
    
    // MARK: View components
    private let mapView: MKMapView
    private let primaryButton = UIButton()
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()

    // MARK: - Life cycle
    
    init(viewModel: MapViewViewModel) {
        self.viewModel = viewModel
        self.mapView = MKMapView(forAutoLayout: ())
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpBinding()
        
        observeViewEffect()
    }
}

// MARK: - Setup

private extension MapViewViewController {

    /// Initializes and configures components in controller.
    func setUpViews() {
        view.backgroundColor = .white
        setUpMap()
    }
    
    func setUpMap() {
        view.addSubview(mapView)
        mapView.autoPinEdgesToSuperviewEdges()
        handlePins()
        setUpPrimaryButton()
    }
    
    func setUpPrimaryButton() {
        view.addSubview(primaryButton)
        primaryButton.autoAlignAxis(toSuperviewAxis: .vertical)
        primaryButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 50)
        primaryButton.autoSetDimension(.height, toSize: 50)
        primaryButton.autoSetDimension(.width, toSize: 200, relation: .greaterThanOrEqual)
        primaryButton.layer.cornerRadius = 4.0
        
        primaryButton.backgroundColor = ColorTheme.primaryAppColor
        primaryButton.setTitle(
            "map_vehicles_primary_button".localizedString(),
            for: .normal
        )
        
        primaryButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            self.viewAction.accept(.primaryButtonPressed)
        })
        .disposed(by: disposeBag)
    }
    
    func handlePins() {
        viewModel.positions.forEach { position in
            addPinToMap(position: position)
        }
        zoomMapToPosition(position: viewModel.positions.first)
    }
    func addPinToMap(position: Position) {
        let annotation = MKPointAnnotation()
        let latitidue = position.latitude
        let longitude = position.longitude
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: latitidue,
            longitude: longitude
        )
        mapView.addAnnotation(annotation)
    }
    
    func zoomMapToPosition(position: Position, delta: CLLocationDegrees = 0.05) {

        let latitude:CLLocationDegrees = position.latitude
        
        let longitude:CLLocationDegrees = position.longitude
        
        let latDelta:CLLocationDegrees = delta
        
        let lonDelta:CLLocationDegrees = delta
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(region, animated: false)
    }
    
    /// Binds controller user events to view model.
    func setUpBinding() {
        viewModel.bind(to: viewAction)
    }
}

// MARK: - Rx

private extension MapViewViewController {
    
    /// Starts observing view effects to react accordingly.
    func observeViewEffect() {
        viewModel
            .viewEffect
            .subscribe(onNext: { effect in
                switch effect {
                case .success:
                    break
                case .loading:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}
