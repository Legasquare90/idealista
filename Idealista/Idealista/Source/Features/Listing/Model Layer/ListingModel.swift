import Foundation

protocol ListingModelProtocol {
    func fetchListings() async throws -> [PropertyDataEntity]
}

final class ListingModel: ListingModelProtocol {
    func fetchListings() async throws -> [PropertyDataEntity] {
        do {
            let listingService = ListingService()
            let data = try await listingService.requestEndpoint(.fetchListing)
            let listings = try JSONDecoder().decode([PropertyDataEntity].self, from: data)
            return listings
        } catch {
            throw error
        }
    }
}
