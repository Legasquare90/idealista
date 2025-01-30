import Foundation

struct PropertyDataEntity: Codable {
    let propertyCode: String
    let thumbnail: String
    let floor: String
    let price: Double
    let priceInfo: PriceInfoDataEntity
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
    let multimedia: MultimediaDataEntity
    let features: FeaturesDataEntity
    let parkingSpace: ParkingSpaceDataEntity?
}

struct FeaturesDataEntity: Codable {
    let hasAirConditioning: Bool
    let hasBoxRoom: Bool
    let hasSwimmingPool: Bool?
    let hasTerrace: Bool?
    let hasGarden: Bool?
}

struct MultimediaDataEntity: Codable {
    let images: [ImageDataEntity]
}

struct ImageDataEntity: Codable {
    let url: String
    let tag: String
}

struct ParkingSpaceDataEntity: Codable {
    let hasParkingSpace: Bool
    let isParkingSpaceIncludedInPrice: Bool
}

struct PriceInfoDataEntity: Codable {
    let price: PriceDataEntity
}

struct PriceDataEntity: Codable {
    let amount: Double
    let currencySuffix: String
}
