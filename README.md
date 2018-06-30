# Project 2 - *Flixster*
***Tipster is name of Git repo, Flixster is name of app.***

**Flixster** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User can tap a movie cell to see further details about the movie.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [x] User sees an error message when there's a networking error. 
- [x] Networking error message has "Try Again" button that refreshes the page when tapped. 
- [x] Implemented tab bar to switch between "Now Playing" and "Superhero" movies.
- [x] Superhero movies are displayed using a CollectionView instead of a TableView.
- [x] User can tap a movie poster in the "Superhero" tab to see further details about the movie. 
- [x] User can search for a movie in both "Now Playing" and "Superhero" tabs. 

The following **additional** features are implemented:

- [x] Instead of an unaesthetic cancel button in search bar to hide keyboard when tapped, keyboard will hide when tapping     anywhere on screen, without automatically segueing into further details about the movie. (Screen must be tapped again on a specific movie in order to segue into further details about the movie.)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to extend app by connecting to large movie database instead of just "Now Playing" or "Superhero" that loads more movies as user scrolls down further. 
2. How to better implement the search bar textDidChange function that searches amongst the movie titles, whether with a predicate or not. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<vid src='https://i.imgur.com/tzPd60k.gifv' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

*Describe any challenges encountered while building the app.*

The biggest challenge I faced was implementing the additional feature, about tapping anywhere on the screen to hide the search bar keyboard, of which I go into further detail above. Not only did I have to keep track of if the search bar was being typed into when the screen was tapped, but also how to do a segue into the more detailed view of the movies when the search bar wasn't being typed into. I put this in an if/else statement, and it was easy to implement either the if or the else, but not both. It was also a challenge figuring out where I should put the touch gesture (on the cell, in the entire view, etc.) and how to figure out which cell was tapped. Eventually, I used a function that I did not even know existed, in which the segue will only be called under certain conditions (such as if the search bar is in use or not), and that kept things simple and clean. 

Another, smaller challege was implementing the search bar in the first place. It was alright until I got to the part where it actually did the search, and the predicate mess was confusing and difficult. Eventually, I abandoned the recommendation and just set the predicate to something easier, and it worked out fine. 

All in all, the search bar was probably the thing that gave me the most headaches, but also taught me how to make my code simpler and cleaner. 

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library

## License

    Copyright [2018] [Tarini Singh]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
