import Combine
import Foundation

final class ListingViewModel {
    @Published var listings: [PropertyViewEntity] = []

    var cancellables = Set<AnyCancellable>()

    private let model: ListingModelProtocol
    private let mapper: ListingViewMapperProtocol

    init(model: ListingModelProtocol,
         mapper: ListingViewMapperProtocol) {
        self.model = model
        self.mapper = mapper
    }

    static func buildDefault() -> Self {
        .init(model: ListingModel.buildDefault(),
              mapper: ListingViewMapper())
    }

    @MainActor
    func fetchData() {
        Task {
            do {
                let data = try await model.fetchListings(forceUpdate: true)
                let favoritePropertyIds = try model.fetchFavoriteIds()
                self.listings = data.map { mapper.map(input: $0, favoriteIds: favoritePropertyIds) }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension ListingViewModel {
    func bindToViewController(_ viewController: ListingViewController) {
        viewController.didTapFavoriteViewSubject
            .sink { [weak self] index in
                guard let self else { return }
                self.didTapFavoriteView(index: index)
            }.store(in: &cancellables)
    }

    private func didTapFavoriteView(index: Int) {
        Task {
            let property = listings[index]
            if property.isFavorite {
                model.removeFavoriteProperty(propertyId: property.propertyId) { [weak self] _ in
                    guard let self else { return }
                    self.updatePropertyFavoriteStatus(propertyIndex: index, isFavorite: false)
                }
            } else {
                model.saveFavoriteProperty(propertyId: property.propertyId) { [weak self] _ in
                    guard let self else { return }
                    self.updatePropertyFavoriteStatus(propertyIndex: index, isFavorite: true)
                }
            }
        }
    }

    private func updatePropertyFavoriteStatus(propertyIndex: Int, isFavorite: Bool) {
        DispatchQueue.main.async() { [weak self] in
            guard let self else { return }
            var property = self.listings[propertyIndex]
            property.isFavorite = isFavorite
            property.favoriteText = isFavorite ? Date().createFavoriteText() : nil
            self.listings[propertyIndex] = property
        }
    }
}
