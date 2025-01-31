import Foundation

protocol ListingModelProtocol {
    func fetchListings(forceUpdate: Bool) async throws -> [PropertyDataEntity]
    func fetchFavoriteIds() throws -> [String: Date]
    func saveFavoriteProperty(propertyId: String) async throws
    func removeFavoriteProperty(propertyId: String) throws
}

final class ListingModel: ListingModelProtocol {
    private let cacheKey = "listingModelApiResponse"

    private let service: ListingServiceProtocol
    private let localDatasource: ListingLocalDatasourceProtocol
    private let cacheManager: CacheManager

    init(service: ListingServiceProtocol,
         localDatasource: ListingLocalDatasourceProtocol,
         cacheManager: CacheManager) {
        self.service = service
        self.localDatasource = localDatasource
        self.cacheManager = cacheManager
    }

    static func buildDefault() -> Self {
        return .init(service: ListingService(),
                     localDatasource: ListingLocalDatasource(),
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

    func fetchFavoriteIds() throws -> [String: Date] {
        let properties = try localDatasource.fetchFavoriteProperties()
        return properties.reduce(into: [String: Date]()) {
            $0[$1.propertyCode] = $1.favoriteDate
        }
    }

    func saveFavoriteProperty(propertyId: String) async throws {
        if let propertyData = try await fetchListings(forceUpdate: false).first(where: { $0.propertyCode == propertyId }) {
            localDatasource.saveFavoriteProperty(property: propertyData)
        }
    }

    func removeFavoriteProperty(propertyId: String) throws {
        try localDatasource.removeFavoriteProperty(propertyId: propertyId)
    }
}
