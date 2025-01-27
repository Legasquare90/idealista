final class ListingViewModel {
    @MainActor
    func fetchData() {
        Task {
            do {
                let model = ListingModel()
                let data = try await model.fetchListings()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
