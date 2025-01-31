import Foundation

protocol ListingViewMapperProtocol {
    func map(input: PropertyDataEntity) -> PropertyViewEntity
    func mapFavoriteOptions(input: PropertyViewEntity, favoriteIds: [String: Date]) -> PropertyViewEntity
}

final class ListingViewMapper: ListingViewMapperProtocol {
    func map(input: PropertyDataEntity) -> PropertyViewEntity {
        let location = "\(input.neighborhood), \(input.municipality)"
        let price = Formatter.formatDoubleValue(input.priceInfo.price.amount) + " \(input.priceInfo.price.currencySuffix)"
        let size = Formatter.formatDoubleValue(input.size) + " m2"
        let rooms = "\(input.rooms) hab."

        let exterior = input.exterior ? " exterior" : ""
        let extraInfo = if input.floor == "0" {
            "Bajo" + exterior
        } else {
            "\(input.floor)ª planta" + exterior
        }

        var parkingInfo: String?
        if let parkingSpace = input.parkingSpace, parkingSpace.hasParkingSpace, parkingSpace.isParkingSpaceIncludedInPrice {
            parkingInfo = "Garaje incluido"
        }

        return .init(propertyId: input.propertyCode,
                     thumbnail: input.thumbnail,
                     address: input.address.capitalizingFirstLetter(),
                     location: location,
                     price: price,
                     size: size,
                     rooms: rooms,
                     extraInfo: extraInfo,
                     parkingInfo: parkingInfo,
                     operation: .init(rawValue: input.operation),
                     isFavorite: false)
    }

    func mapFavoriteOptions(input: PropertyViewEntity, favoriteIds: [String: Date]) -> PropertyViewEntity {
        var viewElement = input
        if let date = favoriteIds[input.propertyId] {
            viewElement.isFavorite = true
            viewElement.favoriteText = date.createFavoriteText()
        }
        return viewElement
    }
}
