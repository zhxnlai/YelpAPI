//
//  Category.swift
//  YelpAPI
//
//  Created by Zhixuan Lai on 6/21/16.
//  Copyright © 2016 Zhixuan Lai. All rights reserved.
//

import Foundation
import Argo
import Curry

/// Business category. See [a list of all categories](https://www.yelp.com/developers/documentation/v2/all_category_list).
public struct Category {

    /// name
    public let name: String

    /// alias
    public let alias: String

}

extension Category: Decodable {
    /// Decoce from JSON
    public static func decode(j: JSON) -> Decoded<Category> {
        switch j {
        case .Array(let val):
            switch (val[0], val[1]) {
            case (.String(let name), .String(let alias)):
                return Decoded.Success(Category(name: name, alias: alias))
            default:
                return Decoded.Failure(DecodeError.Custom("Mulformed Category"))
            }
        default:
            return Decoded.Failure(DecodeError.Custom("Mulformed Category"))
        }
    }
}

