import Foundation

protocol ListingViewMapperProtocol {
    func map(input: PropertyDataEntity) -> PropertyViewEntity
}

final class ListingViewMapper: ListingViewMapperProtocol {
    func map(input: PropertyDataEntity) -> PropertyViewEntity {
        let location = "\(input.neighborhood), \(input.municipality)"
        let price = formatDoubleValue(input.priceInfo.price.amount) + " \(input.priceInfo.price.currencySuffix)"
        let size = formatDoubleValue(input.size) + " m2"
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

    private func formatDoubleValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        return formatter.string(from: NSNumber(value: value)) ?? String(format: "%.0f", value)
    }
}
