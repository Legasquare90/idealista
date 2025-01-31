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
                listings = data.map(mapper.map)
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

    func didTapFavoriteView(index: Int) {
        Task {
            try await model.saveFavoriteProperty(propertyId: listings[index].propertyId)
        }
    }
}
