# Movies App

## App Architecture

Apply MVVM architecture pattern.

### Details

1.  **Overviews**

    - Apply MVVM architecture pattern with Protocol Oriented Programming(POP)
    - Apply Dependency Injection
    - Bind Data Using Observable
    - 'Helpers' folder contains Observable class to Bind data between View and View Model
    - 'Constansts' folder contains URLs, Colors
    - 'MovieList' folder contains needed classes for view the movie list
    - 'MovieDetails' folder contains needed classes for view single Movie Screen
    - 'Services' folder contains class API services
    - 'MoviesAppTests' contains unit test classes for ViewModels, Services

2.  **Features**

    - Lists latest trending movies
    - See movie details which includes an overview of the movie

3.  **Requirements**

    - Xcode 12+
    - Swift 5.0+
    - iOS 13+

4.  **Installation**

    - Download the zip file or clone it using "git clone https://github.com/ShazaKashlan/MoviesApp.git"
    - pod install
    - Run the app

5.  **Pod Using**

- Kingfisher
  - Kingfisher is a powerful, pure-Swift library for downloading and caching images from API more details you can find it in
    https://github.com/onevcat/Kingfisher
- ESPullToRefresh
  - is an easy-to-use component that give pull-to-refresh and infinite-scrolling implemention for developers. more details you can finf it here https://github.com/eggswift/pull-to-refresh

6.  **Movie List**

    - MovieListViewController : contains table view to show the movies list
    - Load more movies by using "addPullToRefresh" When scrolling to top offset
    - MovieListViewModel : Control fetch data movies and page number and bind data using Observable

7.  **Movie Detail**

    - MovieDetailViewController : shows movie detail
    - MovieDetailsViewModel : control fetch data from API Service

8.  **Unit Tests**
    - Understand concept of Given-When-Then pattern
    - In “given” part we should put object definitions, mocks definitions, whole initial assumptions.
    - In “when” part we are putting action/behavior that we want to test.
    - “Then” section is dedicated for verification part. Here we should put our assertions.
    - Code Coverage
