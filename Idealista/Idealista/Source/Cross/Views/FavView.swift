import UIKit

final class FavView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: UI.Font.systemRegular, size: 10)
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
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.alignment = .center
        return stackView
    }()

    func setupView(text: String?) {
        self.layer.cornerRadius = 8
        self.backgroundColor = UI.Color.greenery

        [titleLabel, favImageView].forEach(stackView.addArrangedSubview)
        addSubview(stackView)

        if let text {
            titleLabel.text = text
            titleLabel.isHidden = false
            favImageView.image = UI.Image.heartFilled?.withTintColor(.red)
        } else {
            titleLabel.isHidden = true
            favImageView.image = UI.Image.heart
        }

        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favImageView.heightAnchor.constraint(equalToConstant: 24),
            favImageView.widthAnchor.constraint(equalToConstant: 24),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
