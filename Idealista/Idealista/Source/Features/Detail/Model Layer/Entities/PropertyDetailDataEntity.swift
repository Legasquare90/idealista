import Foundation

struct PropertyDetailDataEntity: Codable {
    let adid: Int
    let price: Double
    let priceInfo: PriceInfoDetailDataEntity
    let operation: String
    let propertyType: String
    let extendedPropertyType: String
    let homeType: String
    let state: String
    let multimedia: MultimediaDetailDataEntity
    let propertyComment: String
    let ubication: UbicationDataEntity
    let country: String
    let moreCharacteristics: MoreCharacteristicsDataEntity
    let energyCertification: EnergyCertificationDataEntity
}

struct EnergyCertificationDataEntity: Codable {
    let title: String
    let energyConsumption: CertificationTypeDataEntity
    let emissions: CertificationTypeDataEntity
}

struct CertificationTypeDataEntity: Codable {
    let type: String
}

struct MoreCharacteristicsDataEntity: Codable {
    let communityCosts: Double
    let roomNumber: Int
    let bathNumber: Int
    let exterior: Bool
    let housingFurnitures: String
    let agencyIsABank: Bool
    let energyCertificationType: String
    let flatLocation: String
    let modificationDate: Int
    let constructedArea: Int
    let lift: Bool
    let boxroom: Bool
    let isDuplex: Bool
    let floor: String
    let status: String
}

struct MultimediaDetailDataEntity: Codable {
    let images: [ImageDetailDataEntity]
}

struct ImageDetailDataEntity: Codable {
    let url: String
    let tag: String
    let localizedName: String
    let multimediaId: Int
}

struct PriceInfoDetailDataEntity: Codable {
    let amount: Double
    let currencySuffix: String
}

struct UbicationDataEntity: Codable {
    let latitude: Double
    let longitude: Double
}
