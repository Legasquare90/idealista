import UIKit

final class ListingCell: UITableViewCell {
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray

        if let url = URL(string: "https://img4.idealista.com/blur/WEB_LISTING-M/0/id.pro.es.image.master/58/60/32/1273036727.webp") {
            imageView.downloadImage(from: url)
        }

        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.text = "Callejón Ordóñez, 3"
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.text = "Centro, Leganés"
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.text = "850 €/mes"
        return label
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.text = "65m2 | Piso | 3º"
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
}
