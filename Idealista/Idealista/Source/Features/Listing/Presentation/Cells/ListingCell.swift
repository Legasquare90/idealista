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
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    private let parkingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.Font.systemRegular, size: 14)
        return label
    }()

    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.Font.systemRegular, size: 14)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    private let roomsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.Font.systemRegular, size: 14)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    private let floorLabel: UILabel = {
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

    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .lastBaseline
        stackView.spacing = 16
        return stackView
    }()

    private let extraInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        return stackView
    }()

    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
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
        stackView.layer.cornerRadius = 16
        stackView.clipsToBounds = true
        return stackView
    }()

    private let tagView = TagView()

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
        [priceLabel, parkingLabel].forEach(priceStackView.addArrangedSubview)
        [sizeLabel, roomsLabel, floorLabel].forEach(extraInfoStackView.addArrangedSubview)
        [addressStackView, priceStackView, extraInfoStackView].forEach(labelsStackView.addArrangedSubview)
        [thumbnailImageView, labelsStackView].forEach(contentStackView.addArrangedSubview)
        contentView.addSubview(contentStackView)
        contentView.addSubview(tagView)
    }

    private func setupConstraints() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        addressStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        extraInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 240),
            tagView.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 12),
            tagView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 12)
        ])
    }

    func configureCell(viewModel: PropertyListingModel) {
        if let url = URL(string: viewModel.thumbnail) {
            thumbnailImageView.downloadImage(from: url)
        }
        titleLabel.text = viewModel.address
        subtitleLabel.text = viewModel.location
        priceLabel.attributedText = getAttributedPriceText(viewModel.price)
        sizeLabel.attributedText = getAttributedSizeText(viewModel.size)
        roomsLabel.text = viewModel.rooms
        floorLabel.text = viewModel.extraInfo

        if let parkingInfo = viewModel.parkingInfo {
            parkingLabel.text = parkingInfo
            parkingLabel.isHidden = false
        } else {
            parkingLabel.isHidden = true
        }

        if let operation = viewModel.operation {
            switch operation {
            case .sale:
                tagView.setupView(backgroundColor: .purple,
                                  title: "Venta".uppercased())
            case .rent:
                tagView.setupView(backgroundColor: UIColor(red: 136.0/255.0, green: 176.0/255.0, blue: 75.0/255.0, alpha: 1.0),
                                  title: "Alquiler".uppercased())
            }
            tagView.isHidden = false
        } else {
            tagView.isHidden = true
        }
    }

    private func getAttributedPriceText(_ text: String) -> NSAttributedString {
        let sizeText = NSMutableAttributedString(string: text)
        let currencyText = text.split(separator: " ").last ?? ""
        var currencyRange = (text as NSString).range(of: String(currencyText))
        currencyRange.location -= 1
        currencyRange.length += 1
        if let font = UIFont(name: Constants.Font.systemBold, size: 14) {
            sizeText.addAttribute(.font, value: font, range: currencyRange)
        }
        return sizeText
    }

    private func getAttributedSizeText(_ text: String) -> NSAttributedString {
        let sizeText = NSMutableAttributedString(string: text)
        let superIndexRange = NSRange(location: text.count - 1, length: 1)
        sizeText.addAttribute(.baselineOffset, value: 4, range: superIndexRange)
        if let font = UIFont(name: Constants.Font.systemRegular, size: 10) {
            sizeText.addAttribute(.font, value: font, range: superIndexRange)
        }
        return sizeText
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
