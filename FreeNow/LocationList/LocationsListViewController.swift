import RxSwift
import RxCocoa
import PureLayout
/// Purpose is to show list of locations
/// - Requires: `RxSwift`, `RxCocoa`, `PureLayout`
final class LocationsListViewController: AppViewController {
    
    // MARK: Dependencies
    private let viewModel: LocationsListViewModel
    
    // MARK: Rx
    private let viewAction = PublishRelay<LocationsListViewAction>()
    
    // MARK: View components
    private let tableView = UITableView()
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()
    // MARK: - Life cycle
    
    init(viewModel: LocationsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpBinding()
        
        observeViewEffect()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewNavigationController.isNavigationBarHidden = false
    }
}

// MARK: - Setup

private extension LocationsListViewController {
    
    /// Initializes and configures components in controller.
    func setUpViews() {
        setUpTableView()
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.backgroundColor = ColorTheme.licensePlateBackground
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.className)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    /// Binds controller user events to view model.
    func setUpBinding() {
        viewModel.bind(to: viewAction)
    }
}

// MARK: - Rx

private extension LocationsListViewController {
    
    /// Starts observing view effects to react accordingly.
    func observeViewEffect() {
        viewModel
            .viewEffect
            .subscribe(onNext: { [unowned self] effect in
                switch effect {
                case .success: self.activityView.hideView()
                case .loading: self.activityView.showView()
                case   .error: self.activityView.hideView()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - TableView
extension LocationsListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.className, for: indexPath)
        let locationCell = cell as! LocationTableViewCell
        let locationModel = viewModel.modelForIndex(index: indexPath.row)
        locationCell.fill(with: locationModel)
        return locationCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewAction.accept(.selectedIndex(atIndex: indexPath.row))
    }
}
