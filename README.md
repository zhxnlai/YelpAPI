# YelpAPI
Yelp API in Swift

~~~swift
Yelp.setupWithConsumerKey(consumerKey: String, consumerSecret: String, accessToken: String, accessTokenSecret: String) {
~~~

~~~swift
let params = SearchParameters(location: .Text(LocationText(location: city)))
Business.search(params) {response, error in
    XCTAssertNil(error, error.debugDescription)
}

Business.lookup(biz) {response, error in
    XCTAssertNil(error, error.debugDescription)
    expectation.fulfill()
}

~~~