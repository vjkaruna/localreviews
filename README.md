cinereviews
===========

Client for movie reviews in Swift, for Codepath.

![Screenshot](https://raw.githubusercontent.com/vjkaruna/cinereviews/master/CineReviews.gif)
![Screenshot](https://raw.githubusercontent.com/vjkaruna/cinereviews/master/CineReviewsNetworkError.gif)

Time spent: approx. 10 hours

Implementation
===========
Used the Alamofire (https://github.com/Alamofire/Alamofire) Swift successor to AFNetworking library (semantics similar to AFNetworking.)
Used the SwiftyJSON (https://github.com/lingoer/SwiftyJSON) enumeration-based approach to parsing JSON types to native Swift types.
Used the SDWebImage (https://github.com/rs/SDWebImage) cache and MBProgressBar indicator.


Optional Tasks
===========

- Images cached (using SDWebImage framework.)

Require Tasks
============

- User can view a list of movies from Rotten Tomatoes. Poster images must be loading asynchronously.
- User can view movie details by tapping on a cell
- User sees loading state while waiting for movies API. You can use one of the 3rd party libraries at cocoacontrols.com.
- User sees error message when there's a networking error. You may not use UIAlertView to display the error. See this screenshot for what the error message should look like: network error screenshot.
- User can pull to refresh the movie list.
