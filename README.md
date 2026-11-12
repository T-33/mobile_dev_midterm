# 👨 Dad Joke Generator — Flutter & BLoC Midterm Project

A mobile application built with Flutter demonstrating asynchronous REST API integration and reactive state management using the BLoC (Business Logic Component) pattern.

---

## How to run:
1) in the project directory root run
```bash
flutter pub get
```
2) run
```bash
flutter run -d chrome
```
или запустите на виртуалке в андроид студио

## 📋 Midterm Requirements Checklist

| Requirement | Implementation | Status |
| :--- | :--- | :---: |
| **Flutter Framework** | Cross-platform UI with Material 3 design and responsive layouts | ✅ Pass |
| **State Management (BLoC)** | Architecture separated into Events, States, and BLoC using `flutter_bloc` | ✅ Pass |
| **REST API Integration** | Asynchronous HTTP calls with header customization using `http` package | ✅ Pass |
| **Git Version Control** | Clean commit history, proper repository structure, and `.gitignore` configuration | ✅ Pass |

---

## 📖 Project Description

The application fetches and displays random jokes from the public [icanhazdadjoke](https://icanhazdadjoke.com/api) REST API.

### Key Features:
- **Instant Display:** Automatically fetches and displays a joke upon application startup.
- **On-Demand Fetching:** Users can request a new joke by pressing the refresh button.
- **Reactive State Handling:**
    - **Loading:** Shows a `CircularProgressIndicator` while fetching data.
    - **Success:** Displays the joke inside a styled Material 3 `Card`.
    - **Error:** Handles network failures and timeouts gracefully, providing a retry option.

---

## 🛠️ Tech Stack & Dependencies

- **Language:** Dart
- **Framework:** Flutter (3.x+)
- **State Management:** `flutter_bloc` (^8.1.x)
- **HTTP Client:** `http` (^1.2.x)
- **Data Source:** [icanhazdadjoke.com](https://icanhazdadjoke.com/)

---

## 📂 Project Structure

```text
lib/
├── joke_bloc.dart      # Business logic: Model, Events, States, and JokeBloc
└── main.dart           # Presentation layer: UI, BlocProvider, and BlocBuilder