final class APIClient: APIClientProtocol {

    func request<T: Decodable>(
        _ endpoint: APIEndpoint
    ) async throws -> T {

        guard let url = endpoint.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)

        request.httpMethod = endpoint.method.rawValue

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        do {

            let (data, response) =
                try await URLSession.shared.data(
                    for: request
                )

            guard let httpResponse =
                    response as? HTTPURLResponse else {

                throw NetworkError.invalidResponse
            }

            switch httpResponse.statusCode {

            case 200...299:
                break

            case 401:
                throw NetworkError.unauthorized

            case 500...599:
                throw NetworkError.serverError(
                    httpResponse.statusCode
                )

            default:
                throw NetworkError.serverError(
                    httpResponse.statusCode
                )
            }

            do {

                return try JSONDecoder().decode(
                    T.self,
                    from: data
                )

            } catch {

                throw NetworkError.decodingError
            }

        } catch let error as NetworkError {

            throw error

        } catch {

            throw NetworkError.noInternet
        }
    }
}
