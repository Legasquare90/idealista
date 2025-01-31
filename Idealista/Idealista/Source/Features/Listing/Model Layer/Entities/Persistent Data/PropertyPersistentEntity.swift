import CoreData

@objc(PropertyPersistentEntity)
final class PropertyPersistentEntity: NSManagedObject {
    @NSManaged var propertyCode: String
    @NSManaged var thumbnail: String
    @NSManaged var floor: String
    @NSManaged var priceAmount: Double
    @NSManaged var currencySuffix: String
    @NSManaged var operation: String
    @NSManaged var size: Double
    @NSManaged var exterior: Bool
    @NSManaged var rooms: Int16
    @NSManaged var address: String
    @NSManaged var municipality: String
    @NSManaged var neighborhood: String
    @NSManaged var hasParkingSpace: Bool
    @NSManaged var isParkingSpaceIncludedInPrice: Bool
    @NSManaged var favoriteDate: Date?
}

extension PropertyPersistentEntity {
    @discardableResult
    static func mapFromDataEntity(_ dataEntity: PropertyDataEntity, context: NSManagedObjectContext) -> PropertyPersistentEntity {
        let persistentEntity = PropertyPersistentEntity(context: context)
        persistentEntity.propertyCode = dataEntity.propertyCode
        persistentEntity.thumbnail = dataEntity.thumbnail
        persistentEntity.floor = dataEntity.floor
        persistentEntity.priceAmount = dataEntity.priceInfo.price.amount
        persistentEntity.currencySuffix = dataEntity.priceInfo.price.currencySuffix
        persistentEntity.operation = dataEntity.operation
        persistentEntity.size = dataEntity.size
        persistentEntity.exterior = dataEntity.exterior
        persistentEntity.rooms = Int16(dataEntity.rooms)
        persistentEntity.address = dataEntity.address
        persistentEntity.municipality = dataEntity.municipality
        persistentEntity.neighborhood = dataEntity.neighborhood
        persistentEntity.hasParkingSpace = dataEntity.parkingSpace?.hasParkingSpace ?? false
        persistentEntity.isParkingSpaceIncludedInPrice = dataEntity.parkingSpace?.isParkingSpaceIncludedInPrice ?? false
        persistentEntity.favoriteDate = Date()
        return persistentEntity
    }

    func mapToDataEntity() -> PropertyDataEntity {
        PropertyDataEntity(propertyCode: propertyCode,
                           thumbnail: thumbnail,
                           floor: floor,
                           price: nil,
                           priceInfo: .init(price: .init(amount: priceAmount,
                                                         currencySuffix: currencySuffix)),
                           propertyType: nil,
                           operation: operation,
                           size: size,
                           exterior: exterior,
                           rooms: Int(rooms),
                           bathrooms: nil,
                           address: address,
                           province: nil,
                           municipality: municipality,
                           district: nil,
                           country: nil,
                           neighborhood: neighborhood,
                           latitude: nil,
                           longitude: nil,
                           description: nil,
                           multimedia: nil,
                           features: nil,
                           parkingSpace: .init(hasParkingSpace: hasParkingSpace,
                                               isParkingSpaceIncludedInPrice: isParkingSpaceIncludedInPrice))
    }
}
