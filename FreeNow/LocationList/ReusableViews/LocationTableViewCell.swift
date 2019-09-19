import UIKit

final class LocationTableViewCell: UITableViewCell {

    // MARK: - Properties
    private var locationNameLabel = UILabel()
    
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
extension LocationTableViewCell {
    func fill(with model: LocationModel) {
        locationNameLabel.text = model.name
    }
}

// MARK: - Private
private extension LocationTableViewCell {
    func setUpViews() {
        accessoryType = .disclosureIndicator
        contentView.addSubview(locationNameLabel)
        let locationNameEdgeInsets = UIEdgeInsets(
            top: 20,
            left: 10,
            bottom: 20,
            right: 10
        )
        locationNameLabel.autoPinEdgesToSuperviewEdges(with: locationNameEdgeInsets)
    }
}
