import Foundation

protocol DetailViewMapperProtocol {
    func map(input: PropertyDetailDataEntity) -> PropertyDetailViewEntity
}

final class DetailViewMapper: DetailViewMapperProtocol {
    func map(input: PropertyDetailDataEntity) -> PropertyDetailViewEntity {
        PropertyDetailViewEntity()
    }
}
