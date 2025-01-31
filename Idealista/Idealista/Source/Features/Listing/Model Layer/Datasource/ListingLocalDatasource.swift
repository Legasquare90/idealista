import CoreData

protocol ListingLocalDatasourceProtocol {
    func saveFavoriteProperty(property: PropertyDataEntity)
    func fetchFavoriteProperties() throws -> [PropertyPersistentEntity]
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
}
