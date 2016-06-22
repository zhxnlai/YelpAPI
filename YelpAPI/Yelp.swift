//
//  YelpAPI.swift
//  YelpAPI
//
//  Created by Zhixuan Lai on 6/20/16.
//  Copyright © 2016 Zhixuan Lai. All rights reserved.
//

import Foundation
import OAuthSwift
import AsyncTask
import Argo

public class Yelp {

    private static var _client : YelpClient?

    public static var client : YelpClient! {
        precondition(Yelp._client != nil, "Should call `Yelp.setupWithConsumerKey` first")
        return _client!
    }

    public static func setupWithConsumerKey(consumerKey: String, consumerSecret: String, accessToken: String, accessTokenSecret: String) {
        precondition(Yelp._client == nil, "Only call `Yelp.setupWithConsumerKey` once")
        Yelp._client = YelpClient(consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: accessToken, accessTokenSecret: accessTokenSecret)
    }

}

public typealias SearchResponseHandler = (SearchResponse?, ErrorType?) -> ()
public typealias LookupResponseHandler = (Business?, ErrorType?) -> ()

public class YelpClient : OAuthSwiftClient {

    let baseURLString = "https://api.yelp.com/v2/"

    public func search(parameters: SearchParameters, completion: SearchResponseHandler) {
        Task {
            do {
                let (data, _) = try self.get(self.baseURLString + "search", parameters: parameters.encode(), headers: nil).await()
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                let searchResponse: Decoded<SearchResponse> = decode(json)

                switch searchResponse {
                case .Success(let response):
                    completion(response, nil)
                case .Failure(let error):
                    debugPrint(json)
                    throw error
                }

            } catch {
                completion(nil, error)
            }
        }.async()
    }

    public func lookup(businessId: String, completion: LookupResponseHandler) {
        Task {
            do {
                let URL = self.baseURLString + "business/\(businessId)"
                let (data, _) = try self.get(URL, parameters: [:], headers: nil).await()
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
                let businessResponse: Decoded<Business> = decode(json)

                switch businessResponse {
                case .Success(let business):
                    completion(business, nil)
                case .Failure(let error):
                    debugPrint(json)
                    throw error
                }
            } catch {
                completion(nil, error)
            }
        }.async()

    }

    func get(urlString: String, parameters: [String : AnyObject], headers: [String : String]?) -> ThrowableTask<(NSData, NSHTTPURLResponse)> {
        return ThrowableTask<(NSData, NSHTTPURLResponse)> {callback in
            self.get(urlString, parameters: parameters, headers: nil, success: {data, response in
                callback(Result.Success((data, response)))
                return
            }) { (error) in
                callback(Result.Failure(error))
            }
        }
    }

}

extension Business {

    public static func search(parameters: SearchParameters, completion: SearchResponseHandler) {
        Yelp.client.search(parameters, completion: completion)
    }

    public static func lookup(name: String, completion: LookupResponseHandler) {
        Yelp.client.lookup(name, completion: completion)
    }

}
