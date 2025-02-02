import Combine
import UIKit

final class DetailViewController: UIViewController {
    private let viewModel = DetailViewModel.buildDefault()

    private var cancellables = Set<AnyCancellable>()

    private var propertyDetail: PropertyDetailViewEntity? {
        didSet {
            renderView()
        }
    }

    private var currentCarouselIndex: Int = 0

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        return collectionView
    }()

    private let counterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UI.Font.systemBold, size: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black.withAlphaComponent(0.5)
        label.clipsToBounds = true
        return label
    }()

    private let basicDataView = PropertyBasicDataView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupView()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }

    private func setupView() {
        view.backgroundColor = UI.Color.greenery
        self.title = "Detail"

        [collectionView, counterLabel, basicDataView].forEach(view.addSubview)
    }

    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        basicDataView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: UI.Size.propertyImage),

            counterLabel.widthAnchor.constraint(equalToConstant: 70),
            counterLabel.heightAnchor.constraint(equalToConstant: 25),
            counterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            counterLabel.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -16),

            basicDataView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            basicDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            basicDataView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    private func setupBinding() {
        viewModel.$propertyDetail
            .assign(to: \.propertyDetail, on: self)
            .store(in: &cancellables)
    }

    private func renderView() {
        guard let propertyDetail else { return }

        collectionView.reloadData()
        updateCounter()
        basicDataView.configureView(viewModel: propertyDetail)
    }

    private func updateCounter() {
        counterLabel.text = "\(currentCarouselIndex + 1)/\(propertyDetail?.images.count ?? 0)"
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        propertyDetail?.images.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }

        if let urlString = propertyDetail?.images[indexPath.item].url {
            cell.configureCell(urlString: urlString)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: UI.Size.propertyImage)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentCarouselIndex = pageIndex
        updateCounter()
    }
}

private extension DetailViewController {
    enum Constants {
        static let cellIdentifier = "imageCell"
    }
}
