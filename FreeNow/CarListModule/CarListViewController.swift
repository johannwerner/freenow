import RxSwift
import RxCocoa
import PureLayout

/// Show a list of cars in a view controller
/// - Requires: `RxSwift`, `RxCocoa`, `PureLayout`
final class CarListViewController: UIViewController {
    
    // MARK: Dependencies
    private let viewModel: CarListViewModel!
    
    // MARK: Rx
    private let viewAction = PublishRelay<CarListViewAction>()
    
    // MARK: View components
    private let tableView = UITableView()
    
    // MARK: Tooling
    private let disposeBag = DisposeBag()
    // MARK: - Life cycle
    
    init(viewModel: CarListViewModel) {
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

private extension CarListViewController {

    /// Initializes and configures components in controller.
    func setUpViews() {
        title = viewModel.locationName
        setUpTableView()
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
        
        tableView.register(CarTableViewCell.self, forCellReuseIdentifier: CarTableViewCell.className)
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

private extension CarListViewController {
    
    /// Starts observing view effects to react accordingly.
    func observeViewEffect() {
        viewModel
            .viewEffect
            .subscribe(onNext: { [unowned self] effect in
                switch effect {
                case .success:
                    self.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - TableView
extension CarListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarTableViewCell.className, for: indexPath)
        let carListCell = cell as! CarTableViewCell
        let carModel = viewModel.modelForIndexPath(index: indexPath.row)
        carListCell.fill(with: carModel)
        return carListCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            viewAction.accept(.selectedIndex(atIndex: indexPath.row))
    }
}
