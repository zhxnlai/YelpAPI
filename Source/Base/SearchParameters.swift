//
//  SearchParameters.swift
//  YelpAPI
//
//  Created by Zhixuan Lai on 6/21/16.
//  Copyright © 2016 Zhixuan Lai. All rights reserved.
//

import Foundation
import CoreLocation

/// Yelp Search Sort Mode
public enum SortMode: Int {
    case BestMatched = 0, Distance, HighestRated
}

/// Yelp Search Location Parameter
public enum LocationParameter {

    /// Specify Location by Neighborhood, Address, or City
    case Text(LocationText)

    /// Specify Location by Geographical Bounding Box
    case Bounds(GeographicalBoundingBox)

    /// Specify Location by Geographic Coordinate
    case Coordinate(GeographicCoordinate)

}

/// The LocationText struct
public struct LocationText {

    /// Specifies the combination of "address, neighborhood, city, state or zip, optional country" to be used when searching for businesses.
    public let location: String

    /// An optional latitude, longitude parameter can also be specified as a hint to the geocoder to disambiguate the location text.
    public let coordinate: CLLocationCoordinate2D?

    public init(location: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.location = location
        self.coordinate = coordinate
    }

}

/// The GeographicalBoundingBox struct
public struct GeographicalBoundingBox {

    /// Southwest latitude of bounding box
    public let southwestLatitude: Double

    /// Southwest longitude of bounding box
    public let southwestLongitude: Double

    /// Northeast latitude of bounding box
    public let northeastLatitude: Double

    /// Northeast longitude of bounding box
    public let northeastLongitude: Double

    public init(southwestLatitude: Double, southwestLongitude: Double, northeastLatitude: Double, northeastLongitude: Double) {
        self.southwestLatitude = southwestLatitude
        self.southwestLongitude = southwestLongitude
        self.northeastLatitude = northeastLatitude
        self.northeastLongitude = northeastLongitude
    }
}

/// The GeographicCoordinate struct
public struct GeographicCoordinate {

    /// Latitude of geo-point to search near
    public let latitude: Double

    /// Longitude of geo-point to search near
    public let longitude: Double

    /// Accuracy of latitude, longitude
    public let accuracy: Double?

    /// Altitude
    public let altitude: Double?

    /// Accuracy of altitude
    public let altitudeAccuracy: Double?

    public init(latitude: Double, longitude: Double, accuracy: Double? = nil, altitude: Double? = nil, altitudeAccuracy: Double? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.accuracy = accuracy
        self.altitude = altitude
        self.altitudeAccuracy = altitudeAccuracy
    }

}

/// https://www.yelp.com/developers/documentation/v2/search_api
public struct SearchParameters {

    /// Search term (e.g. "food", "restaurants"). If term isn’t included we search everything. The term keyword also accepts business names such as "Starbucks".
    public let term: String?

    /// Number of business results to return
    public let limit: Int?

    /// Offset the list of returned business results by this amount
    public let offset: Int?

    /**
     Sort mode: 0=Best matched (default), 1=Distance, 2=Highest Rated. If the mode is 1 or 2 a search may retrieve an additional 20 businesses past the initial limit of the first 20 results. This is done by specifying an offset and limit of 20. Sort by distance is only supported for a location or geographic search. The rating sort is not strictly sorted by the rating value, but by an adjusted rating value that takes into account the number of ratings, similar to a bayesian average. This is so a business with 1 rating of 5 stars doesn’t immediately jump to the top.
    */
    public let sort: SortMode?

    /**
     Category to filter search results with. See the [list of supported categories](https://www.yelp.com/developers/documentation/v2/all_category_list). The category filter can be a list of comma delimited categories. For example, 'bars,french' will filter by Bars and French. The category identifier should be used (for example 'discgolf', not 'Disc Golf').
     */
    public let categoryFilter: [String]?

    /// Search radius in meters. If the value is too large, a AREA_TOO_LARGE error may be returned. The max value is 40000 meters (25 miles).
    public let radiusFilter: Int?

    /// Whether to exclusively search for businesses with deals
    public let dealsFilter: Bool?

    public let location: LocationParameter

    public init(term: String? = nil, limit: Int? = nil, offset: Int? = nil, sort: SortMode? = nil, categoryFilter: [String]? = nil, radiusFilter: Int? = nil, dealsFilter: Bool? = nil, location: LocationParameter) {
        self.term = term
        self.limit = limit
        self.offset = offset
        self.sort = sort
        self.categoryFilter = categoryFilter
        self.radiusFilter = radiusFilter
        self.dealsFilter = dealsFilter
        self.location = location
    }
}

extension SearchParameters {

    func encode() -> [String : AnyObject] {
        var param = [String : AnyObject]()
        param["term"] = term
        param["limit"] = limit
        param["offset"] = offset
        param["sort"] = sort?.rawValue
        param["category_filter"] = categoryFilter?.joinWithSeparator(",")
        param["radius_filter"] = radiusFilter
        param["deals_filter"] = dealsFilter

        switch location {
        case .Text(let text):
            param["location"] = text.location
            param["cll"] = text.coordinate?.encode()
        case .Bounds(let geographicalBoundingBox):
            param["bounds"] = geographicalBoundingBox.encode()
        case .Coordinate(let geographicCoordinate):
            param["ll"] = geographicCoordinate.encode()
        }

        return param
    }

}

extension CLLocationCoordinate2D {
    func encode() -> String {
        return "\(latitude),\(longitude)"
    }
}

extension GeographicalBoundingBox {
    func encode() -> String {
        return "\(southwestLatitude),\(southwestLongitude)|\(northeastLatitude),\(northeastLongitude)"
    }
}
extension GeographicCoordinate {
    func encode() -> String {
        return [latitude, longitude, accuracy, altitude, altitudeAccuracy].flatMap {$0}.map {"\($0)"}.joinWithSeparator(",")
    }
}
