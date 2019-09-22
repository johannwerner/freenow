import UIKit

final class LocationTableViewCell: UITableViewCell {

    // MARK: - Properties
    private let locationNameLabel = UILabel()
    
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
        locationNameLabel.autoPinEdgesToSuperviewEdges(with: locationNameEdgeInsets)
    }
    
    var locationNameEdgeInsets: UIEdgeInsets {
        UIEdgeInsets(
            top: 20,
            left: 10,
            bottom: 20,
            right: 10
        )
    }
}
