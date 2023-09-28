//
//  MetaDataResponse.swift
//  Advanced_iOS_Assessment3
//
//  Created by Christopher Averkos on 26/9/2023.
//

//this is a struct for MetaDataResponse
//it is used to identify the neseasary information for the country that is accessed from
//in our case, we will use Australia
//it would help with using other endpoints.
import Foundation

struct MetaDataResponse: Codable {
    let australia: Australia
    
    enum CodingKeys: String, CodingKey {
        case australia = "AU"
    }
}

struct Australia: Codable {
    let siteId : Int
    let tpId : Int
    let eapId : Int
    let flightsEnabled : Bool
    let carsEnabled : Bool
    let lxEnabled : Bool
    let packagesEnabled : Bool
    let removeAvailabilityMessageEnabled : Bool
    let swapEnabledHotels : Bool
    let earnMessageEnabledHotels : Bool
    let showStrikeThroughPriceDetails : Bool
    let carsWebViewEnabled : Bool
    let url : String?
    let countryCode : String
    let supportedLocales : [SupportedLocales]
    let automaticallyMappedLocales : [String]?
    let branding : String?
    let deepLinkDateFormat : String?
    let pointOfSaleId : Int?
    let shouldDisplayAveragePrices : Bool?
    let shouldShowRewards : Bool?
    let supportsVipAccess : Bool?
    let marketingOptIn : String?
    let shouldDisplayCirclesForRatings : Bool
    let hotMIPSavingsPercentage : String
    let cookiePolicyURLString : String
    let enrollInLoyalty : Bool

    enum CodingKeys: String, CodingKey {

        case siteId = "siteId"
        case tpId = "TPID"
        case eapId = "EAPID"
        case flightsEnabled = "flightsEnabled"
        case carsEnabled = "carsEnabled"
        case lxEnabled = "lxEnabled"
        case packagesEnabled = "packagesEnabled"
        case removeAvailabilityMessageEnabled = "removeAvailabilityMessageEnabled"
        case swapEnabledHotels = "swpEnabled:hotels"
        case earnMessageEnabledHotels = "earnMessageEnabled:hotels"
        case showStrikeThroughPriceDetails = "showStrikeThroughPriceDetails"
        case carsWebViewEnabled = "carsWebViewEnabled"
        case url = "url"
        case countryCode = "countryCode"
        case supportedLocales = "supportedLocales"
        case automaticallyMappedLocales = "automaticallyMappedLocales"
        case branding = "branding"
        case deepLinkDateFormat = "deepLinkDateFormat"
        case pointOfSaleId = "pointOfSaleId"
        case shouldDisplayAveragePrices = "shouldDisplayAveragePrices"
        case shouldShowRewards = "shouldShowRewards"
        case supportsVipAccess = "supportsVipAccess"
        case marketingOptIn = "marketingOptIn"
        case shouldDisplayCirclesForRatings = "shouldDisplayCirclesForRatings"
        case hotMIPSavingsPercentage = "hotMIPSavingsPercentage"
        case cookiePolicyURLString = "cookiePolicyURLString"
        case enrollInLoyalty = "enrollInLoyalty"
    }


}

struct SupportedLocales : Codable {
    let appLanguage : AppLanguage?
    let hotelSiteLocaleIdentifier : String
    let languageCode : String?
    let languageIdentifier : Int
    let localeBasedPointOfSaleName : String?
    let appInfoURL : String?
    let createAccountMarketingText : String?
    let forgotPasswordURL : String?
    let appSupportURLs : AppSupportURLs?
    let bookingSupportURL : String?
    let websiteURL : String?
    let accountURL : String?
    let resultsSortFAQLegalLink : String?
    let termsAndConditionsURL : String?
    let termsOfBookingURL : String?
    let learnAboutSortAndFilterURL : String?
    let privacyPolicyURL : String?
    let loyaltyTermsAndConditionsURL : String?
    let coronavirusInfoUrl : String?

    enum CodingKeys: String, CodingKey {

        case appLanguage = "appLanguage"
        case hotelSiteLocaleIdentifier = "localeIdentifier"
        case languageCode = "languageCode"
        case languageIdentifier = "languageIdentifier"
        case localeBasedPointOfSaleName = "localeBasedPointOfSaleName"
        case appInfoURL = "appInfoURL"
        case createAccountMarketingText = "createAccountMarketingText"
        case forgotPasswordURL = "forgotPasswordURL"
        case appSupportURLs = "appSupportURLs"
        case bookingSupportURL = "bookingSupportURL"
        case websiteURL = "websiteURL"
        case accountURL = "accountURL"
        case resultsSortFAQLegalLink = "resultsSortFAQLegalLink"
        case termsAndConditionsURL = "termsAndConditionsURL"
        case termsOfBookingURL = "termsOfBookingURL"
        case learnAboutSortAndFilterURL = "learnAboutSortAndFilterURL"
        case privacyPolicyURL = "privacyPolicyURL"
        case loyaltyTermsAndConditionsURL = "loyaltyTermsAndConditionsURL"
        case coronavirusInfoUrl = "coronavirusInfoUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        appLanguage = try values.decodeIfPresent(AppLanguage.self, forKey: .appLanguage)
        hotelSiteLocaleIdentifier = try values.decode(String.self, forKey: .hotelSiteLocaleIdentifier)
        languageCode = try values.decodeIfPresent(String.self, forKey: .languageCode)
        languageIdentifier = try values.decode(Int.self, forKey: .languageIdentifier)
        localeBasedPointOfSaleName = try values.decodeIfPresent(String.self, forKey: .localeBasedPointOfSaleName)
        appInfoURL = try values.decodeIfPresent(String.self, forKey: .appInfoURL)
        createAccountMarketingText = try values.decodeIfPresent(String.self, forKey: .createAccountMarketingText)
        forgotPasswordURL = try values.decodeIfPresent(String.self, forKey: .forgotPasswordURL)
        appSupportURLs = try values.decodeIfPresent(AppSupportURLs.self, forKey: .appSupportURLs)
        bookingSupportURL = try values.decodeIfPresent(String.self, forKey: .bookingSupportURL)
        websiteURL = try values.decodeIfPresent(String.self, forKey: .websiteURL)
        accountURL = try values.decodeIfPresent(String.self, forKey: .accountURL)
        resultsSortFAQLegalLink = try values.decodeIfPresent(String.self, forKey: .resultsSortFAQLegalLink)
        termsAndConditionsURL = try values.decodeIfPresent(String.self, forKey: .termsAndConditionsURL)
        termsOfBookingURL = try values.decodeIfPresent(String.self, forKey: .termsOfBookingURL)
        learnAboutSortAndFilterURL = try values.decodeIfPresent(String.self, forKey: .learnAboutSortAndFilterURL)
        privacyPolicyURL = try values.decodeIfPresent(String.self, forKey: .privacyPolicyURL)
        loyaltyTermsAndConditionsURL = try values.decodeIfPresent(String.self, forKey: .loyaltyTermsAndConditionsURL)
        coronavirusInfoUrl = try values.decodeIfPresent(String.self, forKey: .coronavirusInfoUrl)
    }

}

struct AppLanguage: Codable {
    let ios : String?

    enum CodingKeys: String, CodingKey {

        case ios = "ios"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ios = try values.decodeIfPresent(String.self, forKey: .ios)
    }

}

struct AppSupportURLs : Codable {
    let ios : String?

    enum CodingKeys: String, CodingKey {

        case ios = "ios"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ios = try values.decodeIfPresent(String.self, forKey: .ios)
    }

}
