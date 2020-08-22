# weatherApp

### City weather ###

* This app is an evaluation test for iOS developer.

### 1. Architecture
- MVVM architecture: It permits a better separation between the view and the data state of the app, it also makes testing easier.
I preferred to not use third party libraries for data binding and to use closures instead.
- Coordinator: The coordinator pattern is used within the app to separate the navigation flow from the other components, this provides better separation of concerns and give us the ability to construct each module separately. In this project the AppCoordinator represents the starting point of the app and manage the selection of the first coordinator to start.


### 2. Dependency Injection
I used the Current/Environment approach to manage dependencies and centralize them in one instance 'Current', this was used in the Kickstarter open source project and it's very powerful for mocking and testing.
Example: https://twitter.com/pointfreeco/status/999265422989037573

### 3. Third party libraries
The only third party dependency used in the App is "OpenWeatherClient".
This framework is used to fetch weather data  by city names.

### 4. Storage
I chose to save data returned by the API in a json file inside the documents folder, since in our case there are no complex operations demanded (only save and retrieve data).The saving of the data will be after a successful API request, in this case we replace the old data with the new one.
The retrieval of the data will happen if the use's connection is lost, in this case we retrieve data from storage without calling the API.
