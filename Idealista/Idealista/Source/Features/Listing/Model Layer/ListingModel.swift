import Foundation

protocol ListingModelProtocol {
    func fetchListings(forceUpdate: Bool) async throws -> [PropertyDataEntity]
    func fetchFavoriteIds() throws -> [String: Date]
    func saveFavoriteProperty(propertyId: String, completion: @escaping ((Result<Void, Error>) -> Void))
    func removeFavoriteProperty(propertyId: String, completion: ((Result<Void, Error>) -> Void))
}

final class ListingModel: ListingModelProtocol {
    private let cacheKey = "listingModelApiResponse"

    private let service: ListingServiceProtocol
    private let store: ListingStoreProtocol
    private let cacheManager: CacheManager

    init(service: ListingServiceProtocol,
         store: ListingStoreProtocol,
         cacheManager: CacheManager) {
        self.service = service
        self.store = store
        self.cacheManager = cacheManager
    }

    static func buildDefault() -> Self {
        return .init(service: ListingService(),
                     store: ListingStore(),
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
        let properties = try store.fetchFavoriteProperties()
        return properties.reduce(into: [String: Date]()) {
            $0[$1.propertyCode] = $1.favoriteDate
        }
    }

    func saveFavoriteProperty(propertyId: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        Task {
            do {
                if let propertyData = try await fetchListings(forceUpdate: false).first(where: { $0.propertyCode == propertyId }) {
                    store.saveFavoriteProperty(property: propertyData) {
                        completion($0)
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

    func removeFavoriteProperty(propertyId: String, completion: ((Result<Void, Error>) -> Void)) {
        store.removeFavoriteProperty(propertyId: propertyId) {
            completion($0)
        }
    }
}
