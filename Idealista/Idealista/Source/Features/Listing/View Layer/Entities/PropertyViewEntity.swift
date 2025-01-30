struct PropertyViewEntity {
    enum Operation: String {
        case rent
        case sale
    }

    let propertyId: String
    let thumbnail: String
    let address: String
    let location: String
    let price: String
    let size: String
    let rooms: String
    let extraInfo: String
    let parkingInfo: String?
    let operation: Operation?
    var isFavorite: Bool
}

