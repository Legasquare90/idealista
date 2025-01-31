import CoreData

protocol ListingStoreProtocol {
    func saveFavoriteProperty(property: PropertyDataEntity, completion: ((Result<Void, Error>) -> Void))
    func fetchFavoriteProperties() throws -> [PropertyPersistentEntity]
    func removeFavoriteProperty(propertyId: String, completion: ((Result<Void, Error>) -> Void))
}

final class ListingStore: ListingStoreProtocol {
    private let context = CoreDataManager.shared.context

    func saveFavoriteProperty(property: PropertyDataEntity, completion: ((Result<Void, Error>) -> Void)) {
        PropertyPersistentEntity.mapFromDataEntity(property, context: context)

        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(error))
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

    func removeFavoriteProperty(propertyId: String, completion: ((Result<Void, Error>) -> Void)) {
        let fetchRequest = NSFetchRequest<PropertyPersistentEntity>(entityName: "Property")
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyId)

        do {
            if let property = try context.fetch(fetchRequest).first {
                context.delete(property)
                try context.save()
                completion(.success(()))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
