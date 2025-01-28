import UIKit

final class ListingCell: UITableViewCell {
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.Font.systemBold, size: 16)
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.Font.systemRegular, size: 16)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.Font.systemBold, size: 20)
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.Font.systemRegular, size: 14)
        return label
    }()

    private let addressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 0, left: 16, bottom: 16, right: 16)
        return stackView
    }()

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 8
        stackView.clipsToBounds = true
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        [titleLabel, subtitleLabel].forEach(addressStackView.addArrangedSubview)
        [addressStackView, priceLabel, infoLabel].forEach(labelsStackView.addArrangedSubview)
        [thumbnailImageView, labelsStackView].forEach(contentStackView.addArrangedSubview)
        contentView.addSubview(contentStackView)
    }

    private func setupConstraints() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }

    func configureCell(viewModel: PropertyListingModel) {
        if let url = URL(string: viewModel.thumbnail) {
            thumbnailImageView.downloadImage(from: url)
        }
        titleLabel.text = viewModel.address
        subtitleLabel.text = viewModel.location
        priceLabel.text = viewModel.price
        infoLabel.text = viewModel.size
    }
}

private extension ListingCell {
    enum Constants {
        enum Font {
            static let systemBold = "HelveticaNeue-Bold"
            static let systemRegular = "HelveticaNeue"
        }
    }
}
