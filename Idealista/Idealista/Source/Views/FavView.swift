import UIKit

final class FavView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.Font.systemRegular, size: 10)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    private let favImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()

    func setupView(text: String?) {
        [favImageView, titleLabel].forEach(stackView.addArrangedSubview)
        addSubview(stackView)

        if let text {
            titleLabel.text = text
            titleLabel.isHidden = false
            favImageView.image = UIImage(named: "heartFilled")?.withTintColor(.red)
        } else {
            titleLabel.isHidden = true
            favImageView.image = UIImage(named: "heart")
        }

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favImageView.heightAnchor.constraint(equalToConstant: 20),
            favImageView.widthAnchor.constraint(equalToConstant: 20),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

private extension FavView {
    enum Constants {
        enum Font {
            static let systemBold = "HelveticaNeue-Bold"
            static let systemRegular = "HelveticaNeue"
        }
    }
}
