import UIKit

final class ProductViewController: UIViewController {

    private let viewModel: ProductViewModel

    private let tableView = UITableView()

    private let activityIndicator =
        UIActivityIndicatorView(style: .medium)

    init(viewModel: ProductViewModel) {

        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {

        fatalError(
            "init(coder:) has not been implemented"
        )
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Products"

        setupUI()
        bindViewModel()

        Task {
            await viewModel.fetchProducts()
        }
    }
}
extension ProductViewController {

    private func setupUI() {

        view.backgroundColor = .systemBackground

        tableView.translatesAutoresizingMaskIntoConstraints = false

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),

            activityIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            activityIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            )
        ])

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "ProductCell"
        )

        tableView.dataSource = self
    }
}
extension ProductViewController {

    private func bindViewModel() {

        viewModel.onStateChange = { [weak self] in

            guard let self else {
                return
            }

            DispatchQueue.main.async {

                switch self.viewModel.state {

                case .idle:
                    break

                case .loading:
                    self.activityIndicator.startAnimating()

                case .loaded:
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()

                case .error(let message):
                    self.activityIndicator.stopAnimating()
                    self.showError(message)
                }
            }
        }
    }

    private func showError(_ message: String) {

        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(
            alert,
            animated: true
        )
    }
}
extension ProductViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        viewModel.products.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ProductCell",
            for: indexPath
        )

        let product = viewModel.products[indexPath.row]

        var content = cell.defaultContentConfiguration()

        content.text = product.title

        content.secondaryText = String(
            format: "$%.2f",
            product.price
        )

        cell.contentConfiguration = content

        return cell
    }
}
