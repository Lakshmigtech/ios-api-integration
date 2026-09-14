import Foundation

@MainActor
final class ProductViewModel {

    private let service: ProductServiceProtocol

    private(set) var products: [Product] = []

    private(set) var state: ViewState = .idle

    var onStateChange: (() -> Void)?

    init(service: ProductServiceProtocol) {
        self.service = service
    }

    func fetchProducts() async {

        state = .loading
        onStateChange?()

        do {

            products = try await service.fetchProducts()

            state = .loaded
            onStateChange?()

        } catch {

            state = .error(
                error.localizedDescription
            )

            onStateChange?()
        }
    }
}
