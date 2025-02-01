import Combine
import Foundation

final class ListingViewModel {
    private enum Controls: Int {
        case all
        case favorite
    }

    @Published var listings: [PropertyViewEntity] = []

    var cancellables = Set<AnyCancellable>()

    private let model: ListingModelProtocol
    private let mapper: ListingViewMapperProtocol

    private var controlSelected: Controls?

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
    func fetchData(segmentedControlIndex: Int) {
        guard let control = Controls(rawValue: segmentedControlIndex) else { return }

        controlSelected = control

        switch control {
        case .all:
            fetchAllData()
        case .favorite:
            fetchFavoriteData()
        }
    }

    @MainActor
    private func fetchAllData() {
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

    @MainActor
    private func fetchFavoriteData() {
        do {
            let (properties, dates) = try model.fetchFavoriteProperties()
            self.listings = properties.map { mapper.map(input: $0, favoriteIds: dates) }
        } catch {
            print(error.localizedDescription)
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
        Task { @MainActor in
            let property = listings[index]
            if property.isFavorite {
                model.removeFavoriteProperty(propertyId: property.propertyId) { [weak self] _ in
                    guard let self else { return }
                    if let controlSelected, controlSelected == .favorite {
                        self.fetchData(segmentedControlIndex: controlSelected.rawValue)
                    } else {
                        self.updatePropertyFavoriteStatus(propertyIndex: index, isFavorite: false)
                    }
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
