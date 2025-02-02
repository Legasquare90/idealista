import Foundation

protocol DetailViewMapperProtocol {
    func map(input: PropertyDetailDataEntity) -> PropertyDetailViewEntity
}

final class DetailViewMapper: DetailViewMapperProtocol {
    func map(input: PropertyDetailDataEntity) -> PropertyDetailViewEntity {
        let images = input.multimedia.images.map { ImageDetailViewEntity(url: $0.url, localizedName: $0.localizedName) }

        return PropertyDetailViewEntity(propertyId: "",
                                        address: "Callejón Ordóñez, 3",
                                        location: "Centro, Leganés",
                                        price: "850 €/mes",
                                        parkingInfo: "",
                                        isFavorite: false,
                                        favoriteText: nil,
                                        images: images,
                                        description: "",
                                        rooms: "",
                                        bathrooms: "",
                                        exterior: "",
                                        furnitures: "",
                                        size: "",
                                        lift: "",
                                        boxroom: "",
                                        floor: "",
                                        state: "",
                                        energyCertification: .init(title: "",
                                                                   energyConsumption: "",
                                                                   emissions: ""),
                                        lastUpdated: "",
                                        ubication: .init(latitude: 0,
                                                         longitude: 0))
    }
}
