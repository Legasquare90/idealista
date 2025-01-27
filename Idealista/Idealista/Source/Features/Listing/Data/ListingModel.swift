import Foundation

protocol ListingModelProtocol {
    func fetchListings() async throws -> [PropertyListingEntity]
}

final class ListingModel {
    func fetchListings() async throws -> [PropertyListingEntity] {
        do {
            let listingService = ListingService()
            let data = try await listingService.requestEndpoint(.fetchListing)
            let listings = try JSONDecoder().decode([PropertyListingEntity].self, from: data)
            return listings
        } catch {
            throw error
        }
    }
}
