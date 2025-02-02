struct PropertyDetailViewEntity {
    let propertyId: String
    let address: String
    let location: String
    let price: String
    let parkingInfo: String
    var isFavorite: Bool
    var favoriteText: String?
    let images: [ImageDetailViewEntity]
    let description: String
    let rooms: String
    let bathrooms: String
    let exterior: String
    let furnitures: String
    let size: String
    let lift: String
    let boxroom: String
    let floor: String
    let state: String
    let energyCertification: EnergyCertification
    let lastUpdated: String
    let ubication: Ubication
}

struct ImageDetailViewEntity {
    let url: String
    let localizedName: String
}

struct EnergyCertification {
    let title: String
    let energyConsumption: String
    let emissions: String
}

struct Ubication {
    let latitude: Double
    let longitude: Double
}
