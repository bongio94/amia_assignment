# Dog Collection App

## Overview
Dog Collection is a Flutter application that allows users to explore various dog breeds, view random dog images, and manage their favorite breeds. The app utilizes the Dog API to fetch breed information and images.

## Features
- Browse a list of dog breeds
- View random dog images
- See details and images for specific breeds
- Mark breeds as favorites
- Dark and light theme support
- Responsive design for various screen sizes

## Technologies Used
- Flutter
- Riverpod for state management
- Hive for local storage
- HTTP package for API requests

## Getting Started
1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## Project Structure
- `lib/src/data`: Contains data models and repository
- `lib/src/presentation`: UI components and theme
- `lib/src/router`: App routing configuration

## API
This app uses the [Dog API](https://dog.ceo/dog-api/) for fetching dog breed information and images.