//
//  Location.swift
//  YelpAPI
//
//  Created by Zhixuan Lai on 6/21/16.
//  Copyright © 2016 Zhixuan Lai. All rights reserved.
//

import Foundation
import Argo
import Curry
import CoreLocation

/// Location data for a business
public struct Location {

    /// Address for this business. Only includes address fields.
    public let address: [String]

    /// Address for this business formatted for display. Includes all address fields, cross streets and city, state_code, etc.
    public let displayAddress: [String]

    /// City for this business
    public let city: String

    /// ISO 3166-2 state code for this business
    public let stateCode: String

    /// Postal code for this business
    public let postalCode: String

    /// ISO 3166-1 country code for this business
    public let countryCode: String

    /// Cross streets for this business
    public let crossStreets: String?

    /// List that provides neighborhood(s) information for business
    public let neighborhoods: [String]?

    /// Coordinates of this location. This will be omitted if coordinates are not known for the location.
    public let coordinate: CLLocationCoordinate2D?
    
}

extension Location: Decodable {
    /// Decoce from JSON
    public static func decode(j: JSON) -> Decoded<Location> {
        let a = curry(Location.init)
            <^> j <|| "address"
            <*> j <|| "display_address"
            <*> j <| "city"
            <*> j <| "state_code"
            <*> j <| "postal_code"
        return a
            <*> j <| "country_code"
            <*> j <|? "cross_streets"
            <*> j <||? "neighborhoods"
            <*> j <|? "coordinate"
    }
}

extension CLLocationCoordinate2D: Decodable {
    /// Decoce from JSON
    public static func decode(j: JSON) -> Decoded<CLLocationCoordinate2D> {
        return curry(CLLocationCoordinate2D.init)
            <^> j <| "latitude"
            <*> j <| "longitude"
    }
}