import Combine
import Foundation

final class ListingViewModel {
    @Published var listings: [PropertyListingModel] = []

    private let model: ListingModelProtocol
    private let mapper: ListingViewMapperProtocol

    init(model: ListingModelProtocol,
         mapper: ListingViewMapperProtocol) {
        self.model = model
        self.mapper = mapper
    }

    static func buildDefault() -> Self {
        .init(model: ListingModel(),
              mapper: ListingViewMapper())
    }

    @MainActor
    func fetchData() {
        Task {
            do {
                let data = try await model.fetchListings()
                listings = data.map(mapper.map)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
