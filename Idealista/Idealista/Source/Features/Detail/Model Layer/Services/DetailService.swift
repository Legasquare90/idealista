import Foundation

enum DetailServiceEndpoint {
    case fetchDetail
}

protocol DetailServiceProtocol {
    func requestEndpoint(_ endpoint: DetailServiceEndpoint) async throws -> Data
}

final class DetailService: DetailServiceProtocol {
    func requestEndpoint(_ endpoint: DetailServiceEndpoint) async throws -> Data {
        guard let url = URL(string: getPath(endpoint: endpoint)) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = getHTTPMethod(endpoint: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let body = getBody(endpoint: endpoint) {
            request.httpBody = body
        }

        let session = URLSession(configuration: .default, delegate: SecureURLSessionDelegate(), delegateQueue: nil)
        let (data, response) = try await session.data(for: request)

        guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}

private extension DetailService {
    func getPath(endpoint: DetailServiceEndpoint) -> String {
        switch endpoint {
        case .fetchDetail:
            return "https://idealista.github.io/ios-challenge/detail.json"
        }
    }

    func getHTTPMethod(endpoint: DetailServiceEndpoint) -> String {
        switch endpoint {
        case .fetchDetail:
            return "GET"
        }
    }

    func getBody(endpoint: DetailServiceEndpoint) -> Data? {
        switch endpoint {
        case .fetchDetail:
            return nil
        }
    }
}
