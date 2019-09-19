import RxSwift
import RxCocoa
import MapKit

/// Show a map view
/// - Requires: `RxSwift`, `RxCocoa`

typealias MapBounds = (position1: Position, position2: Position)

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

// MARK: - MARKMKMapViewDelegate
extension MapViewViewController: MKMapViewDelegate {    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated: Bool) {
        viewAction.accept(.mapBoundsUpdated(self.mapView.edgeBounds()))
    }
}


// MARK: - Setup

private extension MapViewViewController {

    /// Initializes and configures components in controller.
    func setUpViews() {
        view.backgroundColor = .white
        setUpMap()
        setUpPrimaryButton()
    }
    
    func setUpMap() {
        view.addSubview(mapView)
        mapView.autoPinEdgesToSuperviewEdges()
        handlePins()
        zoomMapToPosition(position: viewModel.positions.first)
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
            self.viewAction.accept(.mapBoundsUpdated(self.mapView.edgeBounds()))
            self.mapView.delegate = self
        })
        .disposed(by: disposeBag)
    }
    
    func handlePins() {
        viewModel.positions.forEach { position in
            addPinToMap(position: position)
        }
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
            .subscribe(onNext: { [unowned self] effect in
                switch effect {
                case .success:
                    self.handlePins()
                case .loading:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
}

private extension MKMapView {
    func edgeBounds() -> MapBounds {
        let nePoint = CGPoint(x: bounds.maxX, y: bounds.origin.y)
        let swPoint = CGPoint(x: bounds.minX, y: bounds.maxY)
        let neCoord = self.convert(nePoint, toCoordinateFrom: self)
        let swCoord = self.convert(swPoint, toCoordinateFrom: self)
        return (
            position1: neCoord.convert(),
            position2: swCoord.convert()
        )
    }
}

private extension CLLocationCoordinate2D {
    func convert() -> Position {
        Position(
            latitude: latitude,
            longitude: longitude
        )
    }
}
