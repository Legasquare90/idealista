import UIKit

final class TagView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UI.Font.systemBold, size: 12)
        return label
    }()

    func setupView(backgroundColor: UIColor, textColor: UIColor, title: String?) {
        self.layer.cornerRadius = 12
        self.backgroundColor = backgroundColor
        titleLabel.textColor = textColor
        titleLabel.text = title

        addSubview(titleLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ])
    }
}
