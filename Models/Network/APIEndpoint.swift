import Foundation

enum APIEndpoint {

    case products

    var url: URL? {

        switch self {

        case .products:
            return URL(
                string: "https://fakestoreapi.com/products"
            )
        }
    }

    var method: HTTPMethod {

        switch self {

        case .products:
            return .get
        }
    }
}

enum HTTPMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
