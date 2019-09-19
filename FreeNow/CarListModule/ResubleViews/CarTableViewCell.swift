import UIKit

final class CarTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var vehicleTitleLabel = UILabel()
    private var licensePlateView = LicensePlateView()
    private var fuelLabel = UILabel()
    private var modelLabel = UILabel()

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
}

// MARK: - Public
extension CarTableViewCell {
    func fill(with model: CarModel) {
        licensePlateView.setTitle(model.numberPlate)
        fuelLabel.text = model.fuelString
        modelLabel.text = model.model
        accessoryType = .disclosureIndicator
        selectionStyle = .gray
    }
}

// MARK: - Private
private extension CarTableViewCell {
    var hasPosition: Bool {
        true
    }
    
    func setUpViews() {
        setUpVehicleTitleLabel()
        setUpLicensePlateView()
        setUpFuelLabel()
        setUpModelLabel()
    }
    
    func setUpVehicleTitleLabel() {
        contentView.addSubview(vehicleTitleLabel)
        vehicleTitleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        vehicleTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        vehicleTitleLabel.text = "car_list_item_title".localizedString(CLMLComments.vehicleCellTitle)
        vehicleTitleLabel.font = UIFont.systemFont(ofSize: 24)
    }
    
    func setUpLicensePlateView() {
        licensePlateView = LicensePlateView()
        contentView.addSubview(licensePlateView)
        licensePlateView.autoPinEdge(.top, to: .bottom, of: vehicleTitleLabel, withOffset: 10)
        licensePlateView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        licensePlateView.backgroundColor = ColorTheme.licensePlateBackground
        licensePlateView.layer.cornerRadius = 4
    }
    
    func setUpFuelLabel() {
        contentView.addSubview(fuelLabel)
        fuelLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        fuelLabel.autoPinEdge(.top, to: .bottom, of: licensePlateView, withOffset: 10)
    }
    
    func setUpModelLabel() {
        contentView.addSubview(modelLabel)
        modelLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 10)
        modelLabel.autoPinEdge(.top, to: .bottom, of: fuelLabel, withOffset: 10)
        modelLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
    }

}

// MARK: - License Plate View
final private class LicensePlateView: UIView {
    // MARK: - Properties
    private var licensePlateLabel = UILabel()
    private var text: String
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        text = ""
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = ""
        super.init(coder: aDecoder)
        initUI()
    }
}

// MARK: - Accessed outside of LicensePlateView
//  Private but accessed outside side of LicensePlateView
extension LicensePlateView {
    func setTitle(_ title: String) {
        licensePlateLabel.text = title
    }
}

// MARK: - Private
private extension LicensePlateView {
    private var circleSize: CGSize {
        CGSize(
            width: 3,
            height: 3
        )
    }
    // Private is included here to restrict access only to LicensePlateView
    private func initUI() {
        createCircleViews()
        setUpLicensePlateLabel()
    }
    
    private func createCircleViews() {
        for index in 0...3 {
            let circleView = CircleView()
            addSubview(circleView)
            circleView.autoSetDimensions(to: circleSize)
            
            switch index {
            case 0, 1:
                circleView.autoPinEdge(toSuperviewEdge: .top, withInset: 3)
            default:
                circleView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 3)
            }
            
            switch index {
            case 0, 2:
                circleView.autoPinEdge(toSuperviewEdge: .leading, withInset: 3)
            default:
                circleView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 3)
            }
        }
    }
    
    private func setUpLicensePlateLabel() {
        addSubview(licensePlateLabel)
        let licensePlateLabelEdgeInsents = UIEdgeInsets(
            top: 0,
            left: 7,
            bottom: 0,
            right: 7
        )
        licensePlateLabel.autoPinEdgesToSuperviewEdges(with: licensePlateLabelEdgeInsents)
    }
}
