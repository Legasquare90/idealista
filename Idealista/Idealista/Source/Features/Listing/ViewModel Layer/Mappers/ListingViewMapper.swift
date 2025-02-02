import Foundation

protocol ListingViewMapperProtocol {
    func map(input: PropertyDataEntity, favoriteIds: [String: Date]) -> PropertyViewEntity
}

final class ListingViewMapper: ListingViewMapperProtocol {
    func map(input: PropertyDataEntity, favoriteIds: [String: Date]) -> PropertyViewEntity {
        let location = String(format: String(localized: "property_location"),
                              input.neighborhood,
                              input.municipality)
        let price = String(format: String(localized: "property_price"),
                           Formatter.formatDoubleValue(input.priceInfo.price.amount),
                           input.priceInfo.price.currencySuffix)
        let size = String(format: String(localized: "property_size"),
                          Formatter.formatDoubleValue(input.size))
        let rooms = String(format: String(localized: "property_rooms"),
                           input.rooms)

        let exterior = input.exterior ? String(localized: "characteristics_exterior") : ""
        let extraInfo = if input.floor == "0" {
            String(format: String(localized: "property_ground_floor"),
                   exterior)
        } else {
            String(format: String(localized: "property_floor"),
                   Formatter.formatOrdinalNumber(input.floor),
                   exterior)
        }

        var parkingInfo: String?
        if let parkingSpace = input.parkingSpace, parkingSpace.hasParkingSpace, parkingSpace.isParkingSpaceIncludedInPrice {
            parkingInfo = String(localized: "characteristics_parking_included")
        }

        let operation = PropertyViewEntity.Operation(rawValue: input.operation)
        var operationText: String?
        if let operation {
            operationText = switch operation {
            case .sale:
                String(localized: "property_operation_sale").uppercased()
            case .rent:
                String(localized: "property_operation_rent").uppercased()
            }
        }

        var isFavorite: Bool = false
        var favoriteText: String?
        if let date = favoriteIds[input.propertyCode] {
            isFavorite = true
            favoriteText = date.createFavoriteText()
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
                     operation: operation,
                     operationText: operationText,
                     isFavorite: isFavorite,
                     favoriteText: favoriteText)
    }
}
