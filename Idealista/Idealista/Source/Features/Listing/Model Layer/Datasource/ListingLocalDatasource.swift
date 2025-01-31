import CoreData

protocol ListingLocalDatasourceProtocol {
    func saveFavoriteProperty(property: PropertyDataEntity)
    func fetchFavoriteProperties() throws -> [PropertyPersistentEntity]
    func removeFavoriteProperty(propertyId: String) throws
}

final class ListingLocalDatasource: ListingLocalDatasourceProtocol {
    let context = CoreDataManager.shared.context
    
    func saveFavoriteProperty(property: PropertyDataEntity) {
        PropertyPersistentEntity.mapFromDataEntity(property, context: context)

        do {
            try context.save()
            print("Guardado con éxito")
        } catch {
            print("Error al guardar: \(error)")
        }
    }

    func fetchFavoriteProperties() throws -> [PropertyPersistentEntity] {
        let fetchRequest = NSFetchRequest<PropertyPersistentEntity>(entityName: "Property")

        do {
            return try context.fetch(fetchRequest)
        } catch {
            throw error
        }
    }

    func removeFavoriteProperty(propertyId: String) throws {
        let fetchRequest = NSFetchRequest<PropertyPersistentEntity>(entityName: "Property")
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyId)

        do {
            if let property = try context.fetch(fetchRequest).first {
                context.delete(property)
                try context.save()
            }
        } catch {
            throw error
        }
    }
}
