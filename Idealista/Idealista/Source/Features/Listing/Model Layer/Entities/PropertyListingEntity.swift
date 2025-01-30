import Foundation

struct PropertyListingEntity: Codable {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: Double
    let priceInfo: PriceInfoListingEntity
    let propertyType: String
    let operation: String
    let size: Double
    let exterior: Bool
    let rooms: Int
    let bathrooms: Int
    let address: String
    let province: String
    let municipality: String
    let district: String
    let country: String
    let neighborhood: String
    let latitude: Double
    let longitude: Double
    let description: String
    let multimedia: MultimediaListingEntity
    let features: FeaturesListingEntity
    let parkingSpace: ParkingSpaceListingEntity?
}

struct FeaturesListingEntity: Codable {
    let hasAirConditioning: Bool
    let hasBoxRoom: Bool
    let hasSwimmingPool: Bool?
    let hasTerrace: Bool?
    let hasGarden: Bool?
}

struct MultimediaListingEntity: Codable {
    let images: [ImageListingEntity]
}

struct ImageListingEntity: Codable {
    let url: String
    let tag: String
}

struct ParkingSpaceListingEntity: Codable {
    let hasParkingSpace: Bool
    let isParkingSpaceIncludedInPrice: Bool
}

struct PriceInfoListingEntity: Codable {
    let price: PriceListingEntity
}

struct PriceListingEntity: Codable {
    let amount: Double
    let currencySuffix: String
}
