//
//  Business.swift
//  YelpAPI
//
//  Created by Zhixuan Lai on 6/21/16.
//  Copyright © 2016 Zhixuan Lai. All rights reserved.
//

import Foundation
import Argo
import Curry

/**
 Yelp Business Model
 https://www.yelp.com/developers/documentation/v2/business
 */
public struct Business {

    /// Yelp ID for this business
    public let id: String

    /// Whether business has been claimed by a business owner
    public let isClaimed: Bool

    /// Whether business has been (permanently) closed
    public let isClosed: Bool

    /// Name of this business
    public let name: String

    /// URL of photo for this business
    public let imageURL: String

    /// URL for business page on Yelp
    public let URL: String

    /// URL for mobile business page on Yelp
    public let mobileURL: String

    /// Phone number for this business with international dialing code (e.g. +442079460000)
    public let phone: String?

    /// Phone number for this business formatted for display
    public let displayPhone: String?

    /// Number of reviews for this business
    public let reviewCount: Int

    /** Provides a list of category name, alias pairs that this business is associated with. For example,
     `[["Local Flavor", "localflavor"], ["Active Life", "active"], ["Mass Media", "massmedia"]]`
     The alias is provided so you can search with the category_filter.
     */
    public let categories: [Category]

    /// Rating for this business (value ranges from 1, 1.5, ... 4.5, 5)
    public let rating: Int

    /// URL to star rating image for this business (size = 84x17)
    public let ratingImageURL: String?

    /// URL to small version of rating image for this business (size = 50x10)
    public let ratingImageURLSmall: String?

    /// URL to large version of rating image for this business (size = 166x30)
    public let ratingImageURLLarge: String?

    /// Yelp ID for this business
    public let snippetText: String?

    /// Yelp ID for this business
    public let snippetImageURL: String?

    /// Location data for this business
    public let location: Location

}

extension Business: Decodable {
    /// Decoce from JSON
    public static func decode(j: JSON) -> Decoded<Business> {
        let a = curry(Business.init)
            <^> j <| "id"
            <*> j <| "is_claimed"
            <*> j <| "is_closed"
            <*> j <| "name"
            <*> j <| "image_url"
            <*> j <| "url"
            <*> j <| "mobile_url"

        return a
            <*> j <|? "phone"
            <*> j <|? "display_phone"
            <*> j <| "review_count"
            <*> j <|| "categories"
            <*> j <| "rating"
            <*> j <|? "rating_image_url"
            <*> j <|? "rating_image_url_small"
            <*> j <|? "rating_image_url_large"
            <*> j <|? "snippet_text"
            <*> j <|? "snippet_image_url"
            <*> j <| "location"
    }
}

extension Business : Hashable {

    public var hashValue: Int {
        return id.hash
    }

}

public func ==(lhs: Business, rhs: Business) -> Bool {
    return lhs.id == rhs.id
}
