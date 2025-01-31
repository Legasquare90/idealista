import Foundation

protocol ListingModelProtocol {
    func fetchListings(forceUpdate: Bool) async throws -> [PropertyDataEntity]
}

final class ListingModel: ListingModelProtocol {
    private let cacheKey = "listingModelApiResponse"

    private let service: ListingServiceProtocol
    private let cacheManager: CacheManager

    init(service: ListingServiceProtocol,
         cacheManager: CacheManager) {
        self.service = service
        self.cacheManager = cacheManager
    }

    static func buildDefault() -> Self {
        return .init(service: ListingService(),
                     cacheManager: CacheManager.shared)
    }

    func fetchListings(forceUpdate: Bool) async throws -> [PropertyDataEntity] {
        if !forceUpdate, let cachedData = cacheManager.getData(forKey: cacheKey) {
            return try JSONDecoder().decode([PropertyDataEntity].self, from: cachedData)
        } else {
            do {
                let data = try await service.requestEndpoint(.fetchListing)
                return try JSONDecoder().decode([PropertyDataEntity].self, from: data)
            } catch {
                throw error
            }
        }
    }
}
