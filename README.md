# Dog Collection App

## Overview
Dog Collection is a Flutter application that allows users to explore various dog breeds, view random dog images, and manage their favorite breeds. The app utilizes the  [Dog API](https://dog.ceo/dog-api/) to fetch breed information and images.

## Features
- Browse a comprehensive list of dog breeds
- View and swipe through random dog images
- Explore detailed information and multiple images for specific breeds
- Mark and manage favorite breeds
- Seamless dark and light theme support
- Explore sub-breeds for applicable dog breeds

## How to use it

When first opening the app the users will see two buttons and a bottom navigation bar.

- The first button will take the users to the random dog images screen where they can select a breed or a sub-breed and tap the *I want more* button to refresh the image provider and load a new random image.

- The second button will take the users to detailed list of breeds. In this screen they can see the list of all of the breeds and the information about how many sub-breeds there are for each breed. By tapping the heart shaped icon button on the right they can add a breed to their favorites.

- For navigating back to the home screen the users can use the OS navigation gestures or tap the *Home* button on the bottom navigation bar.

- The *Favorites* button on the bottom navigation bar will take the users to the list of their favorite breeds. In this screen they can see the list of all of their favorite breeds and by tapping the heart shaped icon button on the right they can remove a breed from their favorites.

## Additional notes

When developing this app I've tried to use platform specific widgets when possible.

The main examples are the loading indicators and routes animations. I could have added more adaptive widgets (radio buttons for example) but decided not to for maintaining a visually pleasing UI.

## Third Party Packages Used
- Riverpod for state management
- Hive for local storage
- GoRouter for navigation
- HTTP package for API requests

## Getting Started
1. Clone the repository: `git clone https://github.com/yourusername/dog-collection-app.git`
2. Navigate to the project directory: `cd dog-collection-app`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Project Structure
- `lib/src/data`: Data models, repository, and API services
- `lib/src/presentation`: Views, widgets, and theming
- `lib/src/router`: App routing configuration and navigation logic
