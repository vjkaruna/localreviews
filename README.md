localreviews
===========

![Screenshot](https://raw.githubusercontent.com/vjkaruna/localreviews/master/LocalReviews.gif)

Client for local restaurant reviews in Swift, for Codepath.

Time spent: 15 hours

Implementation
===========
- Used the Alamofire (https://github.com/Alamofire/Alamofire) Swift successor to AFNetworking library (semantics similar to AFNetworking.)
- Used the SwiftyJSON (https://github.com/lingoer/SwiftyJSON) enumeration-based approach to parsing JSON types to native Swift types.
- Used the SDWebImage (https://github.com/rs/SDWebImage) cache and MBProgressBar indicator.

Required Tasks
===========
- Search results from YELP Api
- Search bar built into Navigation Bar
- Search Rows built with Auto Layout
- Filter view
- Sort options for filter


Issues
=========
Had repeated "segmentation faults" on compiling with NSArray of 1000+ elements for categories, used a subset for NSArray in model.
