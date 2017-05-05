# CarsSearch
Simple Application to search for cars and favorite them

### Basic feature set

**UI:**

Setup 2 screens with a tab bar. The first screen is the list of cars. Second screen is a favorite list. 

*List of cars:* Show the following car properties: Price, Milage, Make, FuelType. Introduce a Pull-to-refresh mechanism for this list with an activity indicator. Each car on the list has a favorite [Switch](https://developer.apple.com/ios/human-interface-guidelines/ui-controls/switches/). When it's switched on, the car is added to the favorites list. When it's switched off, the car is removed from the favorites list.

*List of favorites:* It shows all the cars which are favorited. Each item on this list has a delete button. When the delete button is tapped, that car is removed from the favorites list. This should be reflected on the cars list.

**Networking:**

Use the following network datasource to get the list of cars: http://sumamo.de/iOS-TechChallange/api/index/make=all.json

**Data handling:**

Add a persistence layer for the app, which should be utilized by the favorites list. When the app terminates for any reason and is restarted, the favorites list needs to maintain a consistent state.

**Multithreading:**

Implement all the features so that the user interface is responsive and smooth at all times.
