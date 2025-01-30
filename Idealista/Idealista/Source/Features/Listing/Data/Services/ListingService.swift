import Foundation

enum ListingServiceEndpoint {
    case fetchListing
}

protocol ListingServiceProtocol {
    func requestEndpoint(_ endpoint: ListingServiceEndpoint) async throws -> Data
}

final class ListingService: ListingServiceProtocol {
    func requestEndpoint(_ endpoint: ListingServiceEndpoint) async throws -> Data {
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

private extension ListingService {
    func getPath(endpoint: ListingServiceEndpoint) -> String {
        switch endpoint {
        case .fetchListing:
            return "https://idealista.github.io/ios-challenge/list.json"
        }
    }

    func getHTTPMethod(endpoint: ListingServiceEndpoint) -> String {
        switch endpoint {
        case .fetchListing:
            return "GET"
        }
    }

    func getBody(endpoint: ListingServiceEndpoint) -> Data? {
        switch endpoint {
        case .fetchListing:
            return nil
        }
    }
}
