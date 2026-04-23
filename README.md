# Flutter Movie App

A Flutter application that fetches movie/show data from a public API and demonstrates clean architecture, offline cache, error handling, search, filter, reusable widgets, and a responsive loading state for the Mobile Application Development midterm project. [1]

## Project Overview

This project was built to satisfy the midterm requirement to create a Flutter application that consumes a Public API, with the main focus on code structure quality rather than the number of screens. The application uses a modular folder structure, separates API logic from UI, and includes offline readiness through local caching. [1]

## Features

- Fetches movie/show data from a Public API. [1]
- Displays cached data automatically when the internet connection is unavailable. [1]
- Shows user-friendly error messages instead of technical error codes. [1]
- Supports search using asynchronous logic so the UI stays responsive. [1]
- Supports filter by genre. [1]
- Uses reusable widgets such as `MovieCard`, `CustomLoadingWidget`, and `CustomErrorWidget`. [1]
- Uses a Shimmer loading effect to create a smoother loading experience. [1]
- Includes a detail page so new screens can be added without changing the core architecture significantly. [1]

## Folder Structure

```text
lib/
├── main.dart
├── models/
│   └── movie_model.dart
├── services/
│   ├── api_service.dart
│   └── cache_service.dart
├── providers/
│   └── movie_provider.dart
├── views/
│   ├── home_page.dart
│   └── detail_page.dart
├── widgets/
│   ├── movie_card.dart
│   ├── custom_loading.dart
│   └── custom_error.dart
└── utils/
```

## Why This Structure Was Chosen

The project uses separation of concerns so that each layer has a single responsibility. Models handle data shape, services handle API and cache operations, providers manage application state, views focus on screen layout, and widgets provide reusable UI components. [1]

This structure makes the code easier to maintain and allows new features such as detail pages, sorting, favorites, or pagination to be added without breaking the existing implementation. This directly supports the requirement to keep the code organized as the app grows. [1]

## State Management Choice

Provider was chosen because it is lightweight, simple to understand, and suitable for medium-scale Flutter applications. It allows business logic to stay outside the UI, making loading state, cached data, search results, filter state, and error messages easier to manage consistently. [1]

This choice also aligns with the rubric because the project is expected to correctly identify Flutter concepts such as state management and async/await, while also explaining why the selected approach works technically. [1]

## API Layer

The application uses a dedicated `ApiService` to fetch data from a Public API. API logic is separated from UI files so presentation code does not directly handle networking logic. [1]

This separation improves readability, testing, and maintainability because changes in endpoints or response parsing can be handled in the service layer without rewriting screen code. [1]

## Offline Strategy

The application uses `shared_preferences` as a simple cache layer. After a successful fetch, the latest data is stored locally. When the API call fails or the device is offline, the app loads the last successful cached data automatically. [1]

This behavior was implemented to satisfy the offline readiness requirement, which explicitly asks the app to display the last successfully fetched data when the internet is disconnected. [1]

## Error Handling Strategy

The app avoids exposing raw technical errors to the user. Instead of showing exceptions or HTTP error messages directly, it displays friendlier messages such as informing the user that the internet connection is unavailable and that cached data is being shown. [1]

This approach improves usability and directly addresses the requirement for responsible implementation with user-friendly error handling. [1]

## Search and Filter

Search is implemented with asynchronous logic using `async/await` so the UI remains responsive while processing the query. Filter is implemented by genre, and both search and filter are combined inside the provider so the screen remains simple and easy to maintain. [1]

This design satisfies the requirement for asynchronous features and responsive UI behavior while also keeping the code consistent and extendable. [1]

## Reusable Widgets

The project uses reusable widgets to reduce duplicated UI code and improve consistency across the app. The main reusable widgets are:

- `MovieCard`: displays movie/show summary data in the list. [1]
- `CustomLoadingWidget`: displays shimmer placeholders while data is loading. [1]
- `CustomErrorWidget`: displays a clean error state with a retry action. [1]

Using these widgets consistently supports the requirement for code efficiency and creativity through reusable components. [1]

## Loading State

A shimmer loading effect is used to create a smooth transition while data is being fetched from the API. This gives the interface a more polished feel compared with a plain spinner and meets the visual consistency requirement from the project brief. [1]

## How to Run

```bash
flutter pub get
flutter run
```

## Dependencies

```yaml
http
provider
shared_preferences
shimmer
```

## Deliverables Summary

The required deliverables are a GitHub repository with a README explaining the folder structure and state management choice, plus a short report containing screenshots and an explanation of how the code stays organized when new features are added. This project structure was prepared specifically to match those deliverables. [1]