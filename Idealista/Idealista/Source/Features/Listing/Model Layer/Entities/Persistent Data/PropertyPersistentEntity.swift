import CoreData

@objc(PropertyPersistentEntity)
class PropertyPersistentEntity: NSManagedObject {
    @NSManaged var propertyCode: String
    @NSManaged var thumbnail: String
    @NSManaged var floor: String
    @NSManaged var priceAmount: Double
    @NSManaged var currencySuffix: String
    @NSManaged var operation: String
    @NSManaged var size: Double
    @NSManaged var exterior: Bool
    @NSManaged var rooms: Int
    @NSManaged var address: String
    @NSManaged var municipality: String
    @NSManaged var neighborhood: String
    @NSManaged var hasParkingSpace: Bool
    @NSManaged var isParkingSpaceIncludedInPrice: Bool
}
