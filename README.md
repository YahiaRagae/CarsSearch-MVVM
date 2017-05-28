# Cars Search
Simple Application to search for cars and favorite them

## Fetaures 
-  2 screens with a tab bar. The first screen is the list of cars. Second screen is a favorite list
-  Load Cars List from The Internet.
-  Favorites are kept even after application close. 
-  Responsive and smooth  user interface  at all times.

## Additional Fetaures ( 8 )
- (**UI**) : Introduce floating bar on the bottom of the favorite list.
- (**Networking**) Make sure that each and every response of a request ignores locally or remotely cached data.
- (**Data handling**) Utilize the make parameter of the datasource of the car list screen.
- (**Data handling**) Introduce a sorting feature.
- (**Data handling**) Introduce a validation feature
- (**Multithreading**) Show the first image of each vehicle.
- (**Multithreading**) Show the Address property of each vehicle, but with a 2 seconds delay.
- (**Architecture**) Add a badge to the tab bar favorites list item

## Issues ##
- There is an issue with from the server side when fetching the Data of specific Filter " BMW " which is returning wrong results including other car makers - check the json file within the repo. 

## Platforms ##
-  iOS 9.0+ .


## Desgin Pattern Used ##
-  MVVM 
-  Single Tone :  FavoritesController ,  DataAccessController .
-  Repository Pattern : DataAccessController 
-  Facade Pattern : DataAccessController : Which provides a simplified interface for the Data Access Layer 

## Language ##
- Swift 3 .
- objective - c .


## Libraries Used ## 
- [Alamofire] ( https://github.com/Alamofire/Alamofire )
- [AlamofireImage] ( https://github.com/Alamofire/Alamofire )
- [MBProgressHUD] ( https://github.com/jdg/MBProgressHUD )
- [SwiftyJSON] ( https://github.com/SwiftyJSON/SwiftyJSON )
- [Toast] ( https://github.com/scalessec/Toast )
- [IQKeyboardManagerSwift] ( https://github.com/hackiftekhar/IQKeyboardManager )
- [AFViewShaker] ( https://github.com/ArtFeel/AFViewShaker )












