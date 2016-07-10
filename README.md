# YelpAPI
[![Version](https://img.shields.io/cocoapods/v/YelpAPISwift.svg?style=flat)](http://cocoapods.org/pods/YelpAPISwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/zhxnlai/YelpAPI)
[![License](https://img.shields.io/cocoapods/l/YelpAPISwift.svg?style=flat)](http://cocoapods.org/pods/YelpAPISwift)
[![Platform](https://img.shields.io/cocoapods/p/YelpAPISwift.svg?style=flat)](http://cocoapods.org/pods/YelpAPISwift)
<!--
[![CI Status](http://img.shields.io/travis/zhxnlai/YelpAPISwift.svg?style=flat)](https://travis-ci.org/zhxnlai/YelpAPISwift)
-->
Yelp API in Swift

## Installation

### [CocoaPods](http://cocoapods.org)
YelpAPI is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YelpAPISwift"
```

### [Carthage](https://github.com/Carthage/Carthage)

**Xcode 7.1 required**

Add this to `Cartfile`

```
github "zhxnlai/YelpAPI" ~> 0.1
```

```
$ carthage update
```

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
    print(response.businesses)
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
