import UIKit

final class PropertyBasicDataView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: UI.Font.systemBold, size: 16)
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: UI.Font.systemRegular, size: 16)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: UI.Font.systemBold, size: 20)
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
        stackView.spacing = 10
        return stackView
    }()

    private let favView = FavView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(favViewTapped))
        favView.addGestureRecognizer(gesture)

        [titleLabel, subtitleLabel].forEach(addressStackView.addArrangedSubview)
        [addressStackView, priceLabel].forEach(labelsStackView.addArrangedSubview)
        addSubview(labelsStackView)
        addSubview(favView)
    }

    private func setupConstraints() {
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        addressStackView.translatesAutoresizingMaskIntoConstraints = false
        favView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            favView.topAnchor.constraint(equalTo: addressStackView.topAnchor),
            favView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    func configureView(viewModel: PropertyDetailViewEntity) {
        titleLabel.text = viewModel.address
        subtitleLabel.text = viewModel.location
        priceLabel.attributedText = viewModel.price.getAttributedPriceText()

        if viewModel.isFavorite {
            favView.setupView(text: viewModel.favoriteText)
        } else {
            favView.setupView(text: nil)
        }
    }

    @objc private func favViewTapped() {
    }
}
