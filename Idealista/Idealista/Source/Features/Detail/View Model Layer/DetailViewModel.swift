import Combine
import Foundation

final class DetailViewModel {
    @Published var detailProperty: PropertyDetailViewEntity?

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
    func fetchData(segmentedControlIndex: Int) {
        Task {
            do {
                let data = try await model.fetchDetail()
                self.detailProperty = mapper.map(input: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
