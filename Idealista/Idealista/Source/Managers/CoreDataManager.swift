import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    private init() {
        let model = Self.createModel()
        persistentContainer = NSPersistentContainer(name: "CoreDataModel", managedObjectModel: model)
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    private static func createModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()

        let entity = NSEntityDescription()
        entity.name = "Property"
        entity.managedObjectClassName = NSStringFromClass(PropertyPersistentEntity.self)

        let propertyCodeAttribute = NSAttributeDescription()
        propertyCodeAttribute.name = "propertyCode"
        propertyCodeAttribute.attributeType = .stringAttributeType
        propertyCodeAttribute.isOptional = false

        let thumbnailAttribute = NSAttributeDescription()
        thumbnailAttribute.name = "thumbnail"
        thumbnailAttribute.attributeType = .stringAttributeType
        thumbnailAttribute.isOptional = false

        let floorAttribute = NSAttributeDescription()
        floorAttribute.name = "floor"
        floorAttribute.attributeType = .stringAttributeType
        floorAttribute.isOptional = false

        let priceAmountAttribute = NSAttributeDescription()
        priceAmountAttribute.name = "priceAmount"
        priceAmountAttribute.attributeType = .doubleAttributeType
        priceAmountAttribute.isOptional = false

        let currencySuffixAttribute = NSAttributeDescription()
        currencySuffixAttribute.name = "currencySuffix"
        currencySuffixAttribute.attributeType = .stringAttributeType
        currencySuffixAttribute.isOptional = false

        let operationAttribute = NSAttributeDescription()
        operationAttribute.name = "operation"
        operationAttribute.attributeType = .stringAttributeType
        operationAttribute.isOptional = false

        let sizeAttribute = NSAttributeDescription()
        sizeAttribute.name = "size"
        sizeAttribute.attributeType = .doubleAttributeType
        sizeAttribute.isOptional = false

        let exteriorAttribute = NSAttributeDescription()
        exteriorAttribute.name = "exterior"
        exteriorAttribute.attributeType = .booleanAttributeType
        exteriorAttribute.isOptional = false

        let roomsAttribute = NSAttributeDescription()
        roomsAttribute.name = "rooms"
        roomsAttribute.attributeType = .integer16AttributeType
        roomsAttribute.isOptional = false

        let addressAttribute = NSAttributeDescription()
        addressAttribute.name = "address"
        addressAttribute.attributeType = .stringAttributeType
        addressAttribute.isOptional = false

        let municipalityAttribute = NSAttributeDescription()
        municipalityAttribute.name = "municipality"
        municipalityAttribute.attributeType = .stringAttributeType
        municipalityAttribute.isOptional = false

        let neighborhoodAttribute = NSAttributeDescription()
        neighborhoodAttribute.name = "neighborhood"
        neighborhoodAttribute.attributeType = .stringAttributeType
        neighborhoodAttribute.isOptional = false

        let hasParkingSpaceAttribute = NSAttributeDescription()
        hasParkingSpaceAttribute.name = "hasParkingSpace"
        hasParkingSpaceAttribute.attributeType = .booleanAttributeType
        hasParkingSpaceAttribute.isOptional = false

        let parkingIncludedInPriceAttribute = NSAttributeDescription()
        parkingIncludedInPriceAttribute.name = "isParkingSpaceIncludedInPrice"
        parkingIncludedInPriceAttribute.attributeType = .booleanAttributeType
        parkingIncludedInPriceAttribute.isOptional = false


        entity.properties = [propertyCodeAttribute,
                             thumbnailAttribute,
                             floorAttribute,
                             priceAmountAttribute,
                             currencySuffixAttribute,
                             operationAttribute,
                             sizeAttribute,
                             exteriorAttribute,
                             roomsAttribute,
                             addressAttribute,
                             municipalityAttribute,
                             neighborhoodAttribute,
                             hasParkingSpaceAttribute,
                             parkingIncludedInPriceAttribute]

        model.entities = [entity]

        return model
    }
}
