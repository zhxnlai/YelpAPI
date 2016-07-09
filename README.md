# YelpAPI
Yelp API in Swift
<!--
[![CI Status](http://img.shields.io/travis/zhxnlai/AsyncTask.svg?style=flat)](https://travis-ci.org/zhxnlai/AsyncTask)
[![Version](https://img.shields.io/cocoapods/v/AsyncTask.svg?style=flat)](http://cocoapods.org/pods/AsyncTask)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/zhxnlai/AsyncTask)
[![License](https://img.shields.io/cocoapods/l/AsyncTask.svg?style=flat)](http://cocoapods.org/pods/AsyncTask)
[![Platform](https://img.shields.io/cocoapods/p/AsyncTask.svg?style=flat)](http://cocoapods.org/pods/AsyncTask)
-->

## Usage

Resgister as a [Yelp developer](https://www.yelp.com/developers/manage_api_keys).

Setup the Yelp client.
~~~swift
Yelp.setupWithConsumerKey(consumerKey:consumerSecret:accessToken:accessTokenSecret:)
~~~

Make use of [Search API](https://www.yelp.com/developers/documentation/v2/search_api) and [Business API](https://www.yelp.com/developers/documentation/v2/business)
~~~swift
let params = SearchParameters(term: "Restaurants")
Business.search(params) {response, error in
    guard error == nil else { print(error) }
    print(response.business)
    print(response.total)
}

Business.lookup(biz) {business, error in
    guard error == nil else { print(error) }
    print(business)
}
~~~

## Author

Zhixuan Lai, zhxnlai@gmail.com

## License

YelpAPI is available under the MIT license. See the LICENSE file for more info.
