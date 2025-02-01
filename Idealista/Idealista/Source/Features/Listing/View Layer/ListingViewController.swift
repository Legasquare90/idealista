import Combine
import UIKit

final class ListingViewController: UIViewController {
    private let viewModel = ListingViewModel.buildDefault()

    let didTapFavoriteViewSubject = PassthroughSubject<Int, Never>()

    private var cancellables = Set<AnyCancellable>()

    private var listings: [PropertyViewEntity] = [] {
        didSet {
            tableView.reloadData()
            updateEmptyView()
        }
    }

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListingCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Todos", "Favoritos"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constants.Font.systemBold, size: 18)
        label.text = "Idealista"
        label.textAlignment = .center
        return label
    }()

    private let header: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 136.0/255.0, green: 176.0/255.0, blue: 75.0/255.0, alpha: 1.0)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupView()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData(segmentedControlIndex: segmentedControl.selectedSegmentIndex)
    }

    private func setupView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self

        segmentedControl.addTarget(self, action: #selector(updateSegmentedControl), for: .valueChanged)

        view.backgroundColor = .white

        header.addSubview(titleLabel)
        [header, segmentedControl, tableView].forEach(view.addSubview)
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        header.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16),

            header.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -8),

            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -8),

            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }

    private func setupBinding() {
        viewModel.bindToViewController(self)

        viewModel.$listings
            .assign(to: \.listings, on: self)
            .store(in: &cancellables)
    }

    @objc private func updateSegmentedControl() {
        viewModel.fetchData(segmentedControlIndex: segmentedControl.selectedSegmentIndex)
    }
}

extension ListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? ListingCell else {
            return UITableViewCell()
        }
        cell.configureCell(viewModel: listings[indexPath.row])
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }

    private func updateEmptyView() {
        if listings.count == 0 {
            let emptyView = EmptyView()
            emptyView.setupView(title: "No tienes ninguna propiedad guardada",
                                subtitle: "¡Márcalas como favoritas para que no se te escapen!")
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = nil
        }
    }
}

extension ListingViewController: ListingCellDelegate {
    func didTapFavoriteView(in cell: ListingCell) {
        if let index = tableView.indexPath(for: cell) {
            didTapFavoriteViewSubject.send(index.row)
        }
    }
}

private extension ListingViewController {
    enum Constants {
        static let cellIdentifier = "cell"

        enum Font {
            static let systemBold = "HelveticaNeue-Bold"
            static let systemRegular = "HelveticaNeue"
        }
    }
}
