import UIKit

// Custom UITableViewCell for displaying a region with an image, name, and checkmark
class RegionCell: UITableViewCell {
    
    // UI components declaration
    let globeImageView = UIImageView()
    let nameLabel = UILabel()
    let checkMarkImageView = UIImageView()
    let chekMarkImg = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let globeImgGrey = UIImage(systemName: "globe.asia.australia.fill")?.withTintColor(.systemGray5, renderingMode: .alwaysOriginal)
    let globeImgGreen = UIImage(systemName: "globe.asia.australia.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let bottomBorderView = UIView()

    // Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellViews()
    }
    
    // Required initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configuration of cell views
    private func setupCellViews() {
        configureAddGlobeImg()
        configureAddNameLbl()
        configureAddCheckMarkImg()
        setGlobeImgViewConstraints()
        setNameLblViewConstraints()
        setCheckMarkImgViewConstraints()
        configureAddBottomBorder()
    }

    // MARK: - RegionCell Objects' Configurations

    // Configure and add globe image view
    private func configureAddGlobeImg() {
        globeImageView.translatesAutoresizingMaskIntoConstraints = false
        globeImageView.contentMode = .scaleAspectFit
        globeImageView.image = globeImgGrey
        contentView.addSubview(globeImageView)
    }
    
    // Configure and add name label
    private func configureAddNameLbl() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
    }
    
    // Configure and add check mark image view
    private func configureAddCheckMarkImg() {
        checkMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkMarkImageView.contentMode = .scaleAspectFit
        checkMarkImageView.image = chekMarkImg
        contentView.addSubview(checkMarkImageView)
    }
    
    // Configure and add bottom border view
    private func configureAddBottomBorder() {
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.backgroundColor = .systemGray5
        contentView.addSubview(bottomBorderView)
        setBottomBorderViewConstraints()
    }
    
    // Update cell configuration based on selection state
    func configureCell(isSelected: Bool) {
        globeImageView.image = isSelected ? globeImgGreen : globeImgGrey
        checkMarkImageView.isHidden = !isSelected
        nameLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 16)
    }
    
    // MARK: - RegionCell Objects' Constraints

    // Constraints for globe image view
    private func setGlobeImgViewConstraints() {
        NSLayoutConstraint.activate([
            globeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            globeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            globeImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            globeImageView.widthAnchor.constraint(equalTo: globeImageView.heightAnchor) // Aspect ratio 1:1
        ])
    }
    
    // Constraints for name label
    private func setNameLblViewConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: globeImageView.trailingAnchor, constant: 12),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: checkMarkImageView.leadingAnchor, constant: -8)
        ])
    }

    // Constraints for check mark image view
    private func setCheckMarkImgViewConstraints() {
        NSLayoutConstraint.activate([
            checkMarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            checkMarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkMarkImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            checkMarkImageView.widthAnchor.constraint(equalTo: checkMarkImageView.heightAnchor) // Aspect ratio 1:1
        ])
    }
    
    // Constraints for bottom border view
    private func setBottomBorderViewConstraints() {
        NSLayoutConstraint.activate([
            bottomBorderView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomBorderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 0.6)
        ])
    }

    // Toggle visibility of the right image view
    func toggleRightImageView(show: Bool) {
        globeImageView.isHidden = !show
    }
    
    // Configure the cell with a view model
    func configure(with viewModel: RegionCellViewModel) {
        nameLabel.text = viewModel.regionName
        nameLabel.font = viewModel.nameLabelFont
        globeImageView.image = viewModel.globeImage
        checkMarkImageView.image = viewModel.checkmarkImage
        checkMarkImageView.isHidden = viewModel.checkmarkImageIsHidden
    }
}

