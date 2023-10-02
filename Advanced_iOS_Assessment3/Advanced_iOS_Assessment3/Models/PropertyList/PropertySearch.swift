//
//  PropertySearch.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 25/9/2023.
//

import Foundation
//this is a file that will have all the property related object from the property response JSON

struct PropertyResponse: Codable {
    let data: PropertyData
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(PropertyData.self, forKey: .data)
    }
}


struct PropertyData : Codable {
    let propertySearch : PropertySearch

    enum CodingKeys: String, CodingKey {
        case propertySearch = "propertySearch"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        propertySearch = try values.decode(PropertySearch.self, forKey: .propertySearch)
    }

}

struct PropertySearch: Codable {
    let typeName: String
    //let filterMetadata: FilterMetadata?
    //let sortAndFilter: UniversalSortAndFilter?
    let properties: [Property]?
    //let propertySearchListings: [PropertySearchListings]?
    //let summary: Summary?
    //let searchCriteria: SearchCriteria?
    //let shoppingContext: ShoppingContext?
    //let map: Map?
    //let clickstream : Clickstream?
    
    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        //case filterMetadata = "filterMetadata"
        //case SortAndFilter = "universalSortAndFilter"
        case properties = "properties"
        //case propertySearchListings = "propertySearchListings"
        //case summary = "summary"
        //case searchCriteria = "searchCriteria"
        //case shoppingContext = "shoppingContext"
        //case map = "map"
        //case clickstream = "clickstream"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeName = try values.decode(String.self, forKey: .typeName)
        //filterMetadata = try values.decodeIfPresent(FilterMetadata.self, forKey: .filterMetadata)
        //universalSortAndFilter = try values.decodeIfPresent(UniversalSortAndFilter.self, forKey: .universalSortAndFilter)
        properties = try values.decodeIfPresent([Property].self, forKey: .properties)
        //propertySearchListings = try values.decodeIfPresent([PropertySearchListings].self, forKey: .propertySearchListings)
        //summary = try values.decodeIfPresent(Summary.self, forKey: .summary)
        //searchCriteria = try values.decodeIfPresent(SearchCriteria.self, forKey: .searchCriteria)
        //shoppingContext = try values.decodeIfPresent(ShoppingContext.self, forKey: .shoppingContext)
        //map = try values.decodeIfPresent(Map.self, forKey: .map)
        //clickstream = try values.decodeIfPresent(Clickstream.self, forKey: .clickstream)
    }
}

struct PropertySearchListings: Codable {
    let typeName: String

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typeName = try values.decode(String.self, forKey: .typeName)
    }

}

struct FilterMetadata : Codable {
    let typename : String?
    let amenities : [Amenities]?
    let neighborhoods : [Neighborhood]?
    let priceRange : PriceRange?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case amenities = "amenities"
        case neighborhoods = "neighborhoods"
        case priceRange = "priceRange"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        amenities = try values.decodeIfPresent([Amenities].self, forKey: .amenities)
        neighborhoods = try values.decodeIfPresent([Neighborhood].self, forKey: .neighborhoods)
        priceRange = try values.decodeIfPresent(PriceRange.self, forKey: .priceRange)
    }

}


struct ShoppingContext : Codable {
    let typename : String?
    let multiItem : String?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case multiItem = "multiItem"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        multiItem = try values.decodeIfPresent(String.self, forKey: .multiItem)
    }

}

struct Amenities: Hashable, Codable {
    let typename : String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case id = "id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }

}

struct Property: Identifiable, Hashable, Codable {
    let id: UUID = UUID()
    let hotelId: String
    let typeName: String
    let name: String
    let availability: Availability
    let propertyImage: PropertyImage?
    //let destinationInfo: DestinationInfo?
    //let legalDisclaimer: String?
    //let listingFooter: String?
    let mapMarker: PropertyMapMarker
    //let neighborhood: Neighborhood?
    //let offerBadge: OfferBadge?
    //let offerSummary : OfferSummary?
    //let pinnedDetails : String?
    let price: Price
    let reviews: Reviews?
    //let sponsoredListing : String?
    //let star : String?
    //let supportingMessages : String?
    let regionId : String
    //let priceMetadata : PriceMetadata?
    //let saveTripItem : String?
    
    //this is used for testing and previews
    init(name: String, formattedPrice: String, formattedDiscount: String, isAvaliable: Bool, roomsAvaliable: Int?, propertyImage: PropertyImage?, review: Double) {
        self.hotelId = "0"
        self.typeName = ""
        self.name = name
        self.price = Price(typeName: "", lead: Lead(typeName: "", amount: 0, currencyInfo: nil, formatted: formattedPrice), strikeOut: StrikeOut(typeName: "", amount: 0, formatted: formattedDiscount))
        self.availability = Availability(typeName: "", isAvailable: isAvaliable, minRoomsLeft: roomsAvaliable)
        self.regionId = ""
        self.mapMarker = PropertyMapMarker(label: "", coordinates: PropertyCoordinates(typeName: "", latitude: 0, longitude: 0))
        self.propertyImage = propertyImage
        self.reviews = Reviews(typeName: "", score: review, total: 10)
    }
    
    enum CodingKeys: String, CodingKey {

        case typeName = "__typename"
        case hotelId = "id"
        //case featuredMessages = "featuredMessages"
        case name = "name"
        case availability = "availability"
        case propertyImage = "propertyImage"
        //case destinationInfo = "destinationInfo"
        //case legalDisclaimer = "legalDisclaimer"
        //case listingFooter = "listingFooter"
        case mapMarker = "mapMarker"
        //case neighborhood = "neighborhood"
        //case offerBadge = "offerBadge"
        //case offerSummary = "offerSummary"
        //case pinnedDetails = "pinnedDetails"
        case price = "price"
        //case priceAfterLoyaltyPointsApplied = "priceAfterLoyaltyPointsApplied"
        //case propertyFees = "propertyFees"
        case reviews = "reviews"
        //case sponsoredListing = "sponsoredListing"
        //case star = "star"
        //case supportingMessages = "supportingMessages"
        case regionId = "regionId"
        //case priceMetadata = "priceMetadata"
        //case saveTripItem = "saveTripItem"
    }

}



//these are used to retrieve the hotel images.
struct PropertyImage: Hashable, Codable {
    let typename: String
    let alt: String?
    let image: HotelImage?
    let subjectId: Int

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case alt = "alt"
        case image = "image"
        case subjectId = "subjectId"
    }
}

struct HotelImage: Hashable, Codable {
    let typeName : String
    let description : String?
    let url : String

    enum CodingKeys: String, CodingKey {
        case typeName = "__typename"
        case description = "description"
        case url = "url"
    }

}
/*
struct UniversalSortAndFilter: Codable {
    let __typename : String?
    let toolbar : Toolbar?
    let revealAction : RevealAction?
    let applyAction : ApplyAction?
    let filterSections : [FilterSections]?
    let sortSections : [SortSections]?

    enum CodingKeys: String, CodingKey {

        case __typename = "__typename"
        case toolbar = "toolbar"
        case revealAction = "revealAction"
        case applyAction = "applyAction"
        case filterSections = "filterSections"
        case sortSections = "sortSections"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        __typename = try values.decodeIfPresent(String.self, forKey: .__typename)
        toolbar = try values.decodeIfPresent(Toolbar.self, forKey: .toolbar)
        revealAction = try values.decodeIfPresent(RevealAction.self, forKey: .revealAction)
        applyAction = try values.decodeIfPresent(ApplyAction.self, forKey: .applyAction)
        filterSections = try values.decodeIfPresent([FilterSections].self, forKey: .filterSections)
        sortSections = try values.decodeIfPresent([SortSections].self, forKey: .sortSections)
    }

}
*/

struct MapSearch: Hashable, Codable {
    let typename : String?
    let subtitle : String?

    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case subtitle = "subtitle"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        subtitle = try values.decodeIfPresent(String.self, forKey: .subtitle)
    }
}
