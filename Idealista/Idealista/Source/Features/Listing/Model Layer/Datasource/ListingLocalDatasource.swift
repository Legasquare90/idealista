import CoreData

protocol ListingLocalDatasourceProtocol {
    func saveFavoriteProperty(property: PropertyDataEntity)
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
}
