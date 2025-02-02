import Combine
import Foundation

final class DetailViewModel {
    @Published var propertyDetail: PropertyDetailViewEntity?

    var cancellables = Set<AnyCancellable>()

    private let model: DetailModelProtocol
    private let mapper: DetailViewMapperProtocol

    init(model: DetailModelProtocol,
         mapper: DetailViewMapperProtocol) {
        self.model = model
        self.mapper = mapper
    }

    static func buildDefault() -> Self {
        .init(model: DetailModel.buildDefault(),
              mapper: DetailViewMapper())
    }

    @MainActor
    func fetchData() {
        Task {
            do {
                let data = try await model.fetchDetail()
                self.propertyDetail = mapper.map(input: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
