//
//  YelpAPITests.swift
//  YelpAPITests
//
//  Created by Zhixuan Lai on 6/21/16.
//  Copyright © 2016 Zhixuan Lai. All rights reserved.
//

import XCTest
import YelpAPI
import AsyncTask

class YelpAPITests: XCTestCase {

    static var onceToken: dispatch_once_t = 0

    override func setUp() {
        dispatch_once(&YelpAPITests.onceToken) {
            Yelp.setupWithConsumerKey("Zt5KH9QFVfTSG6F23htZ1g", consumerSecret: "H5MZtL9n4csO7RD7PEc7_6GBQxc", accessToken: "7ZFnGjWX1Qz5osa56K-aZZRJieTxDmrx", accessTokenSecret: "1dATChTFG92fCQeaTfyvE5trqzU")
        }

        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBusinessSearch() {
        ["New York", "Los Angeles", "Paris", "Singapore", "Tokyo"].forEach {city in
            let expectation = expectationWithDescription("\(city)")
            let params = SearchParameters(location: .Text(LocationText(location: city)))
            Business.search(params) {response, error in
                XCTAssertNil(error, error.debugDescription)
                expectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }

    func testBusinessLookup() {
        // "alegio-chocolaté-palo-alto", "bäckerei-und-konditorei-balzer-berlin"
        ["teaspoon-mountain-view", "papa-cristos-catering-los-angeles", "mashua-amsterdam"].forEach {biz in
            let expectation = expectationWithDescription("\(biz)")
            Business.lookup(biz) {response, error in
                XCTAssertNil(error, error.debugDescription)
                expectation.fulfill()
            }
        }

        waitForExpectationsWithTimeout(10, handler: nil)
    }
    

}

