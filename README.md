# Flutter Firebase ToDo App

A simple ToDo app built with Flutter and Firebase using Provider for state management.

## Key Features

- User Authentication using email/password

- CRUD operations for ToDo items (per user)

- Realtime sync using Cloud Firestore

- Clean and responsive UI

- State management using **Provider**

## Supported Platforms

- Android

## Installation

Follow these steps to install

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter SDK: Ensure that Flutter is installed on your machine. You can download it from [flutter.dev](https://flutter.dev).

- Dart SDK: The Dart SDK is bundled with the Flutter SDK. You can download it from https://dart.dev/get-dart.

- Android Studio/Xcode: For Android and iOS development, install Android Studio or Xcode, respectively.

- Git: Ensure that Git is installed for version control.

### Clone the Repository

1. Open your terminal or command prompt.

2. Use the following command to clone ToDo-App repository:

git clone https://github.com/raghda-ali/ToDo-App.git

### Configuration

1. Change your working directory to the cloned repository:

cd  ToDo-App

1. Install dependencies using this command:

flutter pub get

### Firebase Configuration

1. Go to Firebase Console

2. Create a new project

3. Add an Android app with the package name used in android/app/src/main/AndroidManifest.xml

4. Download the google-services.json and place it in android/app/

5. Enable Email/Password sign-in in Authentication

6. Create a Firestore database in test mode

### Build and Run

1. Connect your device or start an emulator/ simulator.

2. To build and run the project, use the following command:

flutter run 

This will build the project and install it on your connected device or emulator

## State Management Approach

- The app uses the Provider package with ChangeNotifier to manage state cleanly.

- Each feature (Auth and Todos) has its own Provider class, which exposes methods and notifies listeners on state changes.

- Business logic follows Clean Architecture, separating:

 Entities for models

 Repositories for abstract logic

 UseCases for specific operations

 DataSources for Firebase integration

## Screenshots

### Login Page
![LoginPage](https://github.com/raghda-ali/ToDo-App/blob/master/Screenshot_1750147726.png)

### Register Page
![RegisterPage](https://github.com/raghda-ali/ToDo-App/blob/master/Screenshot_1750148049.png)

### Home Page
![HomePage](https://github.com/raghda-ali/ToDo-App/blob/master/Screenshot_1750147686.png)

### Add Task Page
![AddTask](https://github.com/raghda-ali/ToDo-App/blob/master/Screenshot_1750147699.png)

### Edit Task Page
![EditTask](https://github.com/raghda-ali/ToDo-App/blob/master/Screenshot_1750147705.png)
