//
//  SearchResponse.swift
//  YelpAPI
//
//  Created by Zhixuan Lai on 6/21/16.
//  Copyright © 2016 Zhixuan Lai. All rights reserved.
//

import Foundation
import Argo
import Curry

/// Standard response values from a search
public struct SearchResponse {

    /// Total number of business results
    public let total: Int

    /// The list of business entries
    public let businesses: [Business]

}

extension SearchResponse: Decodable {
    /// Decoce from JSON
    public static func decode(j: JSON) -> Decoded<SearchResponse> {
        return curry(SearchResponse.init)
            <^> j <| "total"
            <*> j <|| "businesses"
    }
}

