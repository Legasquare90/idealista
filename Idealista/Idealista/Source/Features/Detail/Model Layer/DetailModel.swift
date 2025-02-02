import Foundation

protocol DetailModelProtocol {
    func fetchDetail() async throws -> PropertyDetailDataEntity
}

final class DetailModel: DetailModelProtocol {
    private let service: DetailServiceProtocol

    init(service: DetailServiceProtocol) {
        self.service = service
    }

    static func buildDefault() -> Self {
        return .init(service: DetailService())
    }

    func fetchDetail() async throws -> PropertyDetailDataEntity {
        do {
            let data = try await service.requestEndpoint(.fetchDetail)
            return try JSONDecoder().decode(PropertyDetailDataEntity.self, from: data)
        } catch {
            throw error
        }
    }
}
