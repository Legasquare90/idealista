import UIKit

final class ListingViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ListingCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
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
        setupView()
        setupConstraints()
    }

    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self

        view.backgroundColor = .white

        header.addSubview(titleLabel)
        [header, tableView].forEach(view.addSubview)
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        header.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16),

            header.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.bottomAnchor.constraint(equalTo: tableView.topAnchor),

            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

extension ListingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? ListingCell else {
            return UITableViewCell()
        }
        return cell
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
