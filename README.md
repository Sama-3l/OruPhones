# Flutter Project using BLoC State Management

This project is built using the **BLoC (Business Logic Component)** state management pattern, ensuring a clean separation of concerns between UI, business logic, and data layers. This architecture helps maintain a scalable and testable codebase.

---

## Project Structure

The project is organized into three main folders under the `lib` directory:

### 1. `assets`
This folder contains all the static resources used in the application:

- **`animations/`**: Stores Lottie or any animation JSON files.
- **`images/`**: Further categorized based on the part of the app they are used in (e.g., splash images, product images, etc.).
- **`svg/`**: Contains SVG assets represented as Dart variables for easy integration.

### 2. `core`
The `core` directory contains reusable global utilities, constants, and foundational elements of the app:

- **`constants/`**: Holds all important constant variables used across the app, such as string literals and URLs.
- **`database/`**: 
  - **Global Data Models**: Models representing the structure of the data used across the app.
  - **Database Query File**: Contains methods and functions for querying the database.
- **`themes/`**: Defines the color schemes, themes, and styles used throughout the app.
- **`utils/`**: Includes various utility methods and helper functions for tasks such as validation, date formatting, or navigation.

### 3. `features`
Each feature of the app is partitioned into its own directory, promoting modularity and separation of concerns. Current features include:

- **`home/`**
- **`auth/`**
- **`splash_screen/`**

Within each feature directory, the following folders are present:

- **`business_logic/`**: Contains all the BLoC and Cubit classes responsible for managing the state and logic of the feature.
- **`presentation/`**: Houses all the screens, pages, and widgets related to the feature.

## Project Structure

### State Management
We are using **BLoC (Business Logic Component)** state management in this project to ensure a clear separation of business logic and UI.

---

---

## State Management with BLoC

BLoC (Business Logic Component) is used as the primary state management approach for this project. It separates the business logic from the UI, making the code more maintainable and testable. Here's a breakdown of how it is used:

- **Cubit**: Manages simple state changes and emits new states.
- **BLoC**: Manages more complex events and state transitions.
- **Streams**: The UI subscribes to state streams to reflect changes in real time.

Example flow for a feature:
1. The UI sends an event to the BLoC.
2. The BLoC processes the event and updates the state.
3. The updated state is emitted, and the UI rebuilds with the new data.

---

## How to Run the App

1. Clone this repository:
   ```bash
   git clone https://github.com/Sama-3l/OruPhones.git

2. Install the required dependencies:
   ```bash
   flutter pub get

3. Run the app:
   ```bash
   flutter run

### Directory Structure

```plaintext
lib/
├── assets/
│   ├── animation_json/
│   ├── images/
│   │   ├── home/
│   │   ├── auth/
│   │   └── splash_screen/
│   └── svg/
│
├── core/
│   ├── constants/
│   │   └── constants.dart
│   ├── database/
│   │   ├── models/
│   │   └── database_queries.dart
│   ├── themes/
│   │   └── app_themes.dart
│   └── utils/
│       ├── validation_utils.dart
│       ├── date_utils.dart
│       └── navigation_utils.dart
│
├── features/
│   ├── auth/
│   │   ├── business_logic/
│   │       └── blocs/
│   │       └── cubits/
│   │   └── presentation/
│   │       └── widgets/
│   │       └── screens/
│   │       └── pages/
│   │
│   ├── home/
│   │   ├── business_logic/
│   │       └── blocs/
│   │       └── cubits/
│   │   └── presentation/
│   │       └── widgets/
│   │       └── screens/
│   │       └── pages/
│   │
│   └── splash_screen/
│       ├── business_logic/
│           └── blocs/
│           └── cubits/
│       └── presentation/
│           └── widgets/
│           └── screens/
│           └── pages/
│
main.dart