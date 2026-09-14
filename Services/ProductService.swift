import Foundation

final class ProductService: ProductServiceProtocol {

    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchProducts() async throws -> [Product] {

        try await apiClient.request(
            .products
        )
    }
}
