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
}


struct PropertyData : Codable {
    let propertySearch : PropertySearch?

    enum CodingKeys: String, CodingKey {
        case propertySearch = "propertySearch"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        propertySearch = try values.decodeIfPresent(PropertySearch.self, forKey: .propertySearch)
    }

}

struct PropertySearch: Codable {
    let typename: String?
    let filterMetadata: FilterMetadata?
    //let sortAndFilter: UniversalSortAndFilter?
    let properties: [Properties]?
    let propertySearchListings: [PropertySearchListings]?
    let summary: Summary?
    let searchCriteria: SearchCriteria?
    let shoppingContext: ShoppingContext?
    let map: Map?
    //let clickstream : Clickstream?
    
    enum CodingKeys: String, CodingKey {
        case typename = "__typename"
        case filterMetadata = "filterMetadata"
        //case SortAndFilter = "universalSortAndFilter"
        case properties = "properties"
        case propertySearchListings = "propertySearchListings"
        case summary = "summary"
        case searchCriteria = "searchCriteria"
        case shoppingContext = "shoppingContext"
        case map = "map"
        //case clickstream = "clickstream"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        filterMetadata = try values.decodeIfPresent(FilterMetadata.self, forKey: .filterMetadata)
        //universalSortAndFilter = try values.decodeIfPresent(UniversalSortAndFilter.self, forKey: .universalSortAndFilter)
        properties = try values.decodeIfPresent([Properties].self, forKey: .properties)
        propertySearchListings = try values.decodeIfPresent([PropertySearchListings].self, forKey: .propertySearchListings)
        summary = try values.decodeIfPresent(Summary.self, forKey: .summary)
        searchCriteria = try values.decodeIfPresent(SearchCriteria.self, forKey: .searchCriteria)
        shoppingContext = try values.decodeIfPresent(ShoppingContext.self, forKey: .shoppingContext)
        map = try values.decodeIfPresent(Map.self, forKey: .map)
        //clickstream = try values.decodeIfPresent(Clickstream.self, forKey: .clickstream)
    }
}

struct PropertySearchListings: Codable {
    let type: String?

    enum CodingKeys: String, CodingKey {
        case type = "__typename"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}

struct FilterMetadata : Codable {
    let typename : String?
    let amenities : [Amenities]?
    let neighborhoods : [Neighborhoods]?
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
        neighborhoods = try values.decodeIfPresent([Neighborhoods].self, forKey: .neighborhoods)
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

struct Amenities : Codable {
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


struct Properties: Codable {
    let typename : String?
    let id : String?
    let featuredMessages : [String]?
    let name: String?
    let availability: Availability?
    let propertyImage: PropertyImage?
    let destinationInfo: DestinationInfo?
    let legalDisclaimer: String?
    let listingFooter: String?
    //let mapMarker : MapMarker?
    let neighborhood : Neighborhood?
    //let offerBadge : OfferBadge?
    //let offerSummary : OfferSummary?
    let pinnedDetails : String?
    let price : Price?
    let priceAfterLoyaltyPointsApplied : PriceAfterLoyaltyPointsApplied?
    let propertyFees : [String]?
    let reviews : Reviews?
    let sponsoredListing : String?
    let star : String?
    let supportingMessages : String?
    let regionId : String?
    let priceMetadata : PriceMetadata?
    let saveTripItem : String?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case id = "id"
        case featuredMessages = "featuredMessages"
        case name = "name"
        case availability = "availability"
        case propertyImage = "propertyImage"
        case destinationInfo = "destinationInfo"
        case legalDisclaimer = "legalDisclaimer"
        case listingFooter = "listingFooter"
        //case mapMarker = "mapMarker"
        case neighborhood = "neighborhood"
        //case offerBadge = "offerBadge"
        //case offerSummary = "offerSummary"
        case pinnedDetails = "pinnedDetails"
        case price = "price"
        case priceAfterLoyaltyPointsApplied = "priceAfterLoyaltyPointsApplied"
        case propertyFees = "propertyFees"
        case reviews = "reviews"
        case sponsoredListing = "sponsoredListing"
        case star = "star"
        case supportingMessages = "supportingMessages"
        case regionId = "regionId"
        case priceMetadata = "priceMetadata"
        case saveTripItem = "saveTripItem"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        featuredMessages = try values.decodeIfPresent([String].self, forKey: .featuredMessages)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        availability = try values.decodeIfPresent(Availability.self, forKey: .availability)
        propertyImage = try values.decodeIfPresent(PropertyImage.self, forKey: .propertyImage)
        destinationInfo = try values.decodeIfPresent(DestinationInfo.self, forKey: .destinationInfo)
        legalDisclaimer = try values.decodeIfPresent(String.self, forKey: .legalDisclaimer)
        listingFooter = try values.decodeIfPresent(String.self, forKey: .listingFooter)
        //mapMarker = try values.decodeIfPresent(MapMarker.self, forKey: .mapMarker)
        neighborhood = try values.decodeIfPresent(Neighborhood.self, forKey: .neighborhood)
        //offerBadge = try values.decodeIfPresent(OfferBadge.self, forKey: .offerBadge)
        //offerSummary = try values.decodeIfPresent(OfferSummary.self, forKey: .offerSummary)
        pinnedDetails = try values.decodeIfPresent(String.self, forKey: .pinnedDetails)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        priceAfterLoyaltyPointsApplied = try values.decodeIfPresent(PriceAfterLoyaltyPointsApplied.self, forKey: .priceAfterLoyaltyPointsApplied)
        propertyFees = try values.decodeIfPresent([String].self, forKey: .propertyFees)
        reviews = try values.decodeIfPresent(Reviews.self, forKey: .reviews)
        sponsoredListing = try values.decodeIfPresent(String.self, forKey: .sponsoredListing)
        star = try values.decodeIfPresent(String.self, forKey: .star)
        supportingMessages = try values.decodeIfPresent(String.self, forKey: .supportingMessages)
        regionId = try values.decodeIfPresent(String.self, forKey: .regionId)
        priceMetadata = try values.decodeIfPresent(PriceMetadata.self, forKey: .priceMetadata)
        saveTripItem = try values.decodeIfPresent(String.self, forKey: .saveTripItem)
    }

}



//these are used to retrieve the hotel images.
struct PropertyImage : Codable {
    let typename : String?
    let alt : String?
    let fallbackImage : String?
    let image : Image?
    let subjectId : Int?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case alt = "alt"
        case fallbackImage = "fallbackImage"
        case image = "image"
        case subjectId = "subjectId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        alt = try values.decodeIfPresent(String.self, forKey: .alt)
        fallbackImage = try values.decodeIfPresent(String.self, forKey: .fallbackImage)
        image = try values.decodeIfPresent(Image.self, forKey: .image)
        subjectId = try values.decodeIfPresent(Int.self, forKey: .subjectId)
    }
}

struct Image : Codable {
    let typename : String?
    let description : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case typename = "__typename"
        case description = "description"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        typename = try values.decodeIfPresent(String.self, forKey: .typename)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        url = try values.decodeIfPresent(String.self, forKey: .url)
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

struct Map: Codable {
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

