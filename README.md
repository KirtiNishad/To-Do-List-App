# To-Do List App (Flutter + Bloc + Firebase)

A modern and responsive **To-Do List mobile application** built using **Flutter**, implementing **Bloc state management** and **Firebase Realtime Database** for backend storage.
The app allows users to manage their daily tasks efficiently with full **CRUD operations**.

---

## Features

* User Authentication

    * Sign Up
    * Login

* Task Management

    * Add new tasks
    * Edit existing tasks
    * Mark tasks as completed
    * Delete tasks

* Modern UI

    * Clean and responsive layout
    * Card-based task list
    * Swipe to delete tasks
    * Dialog based add/edit task

* State Management

    * Implemented using **Bloc Pattern**

* Backend

    * **Firebase Realtime Database** used for storing tasks
    * REST API calls handled using **Dio**

---

## App Architecture

The application follows a **feature-based architecture** with clear separation of concerns.

```
lib/
│
├── core
│   └── network
│       └── api_client.dart
│
├── features
│   ├── auth
│   │   ├── login
│   │   └── sign_up
│   │
│   └── dashboard
│       ├── bloc
│       │   ├── task_bloc.dart
│       │   ├── task_event.dart
│       │   └── task_state.dart
│       │
│       ├── model
│       │   └── task_model.dart
│       │
│       └── view
│           └── task_screen.dart
│
└── main.dart
```

---

## Technologies Used

* Flutter
* Dart
* Bloc (flutter_bloc)
* Firebase Realtime Database
* Dio (HTTP Client)

---

## CRUD Operations

| Operation | Description                          |
| --------- | ------------------------------------ |
| Create    | Add a new task                       |
| Read      | Fetch all tasks from Firebase        |
| Update    | Edit task title or toggle completion |
| Delete    | Remove a task                        |

---

## API Example

Update Task Status

```
PATCH /tasks/{taskId}.json
```

Request Body:

```
{
  "isCompleted": true
}
```

---

## State Management Flow

```
UI → Event → Bloc → API → State → UI Rebuild
```

Example:

```
User clicks Edit Task
       ↓
EditTask Event
       ↓
TaskBloc processes event
       ↓
Firebase API called
       ↓
TaskLoaded State emitted
       ↓
UI automatically rebuilds
```

---

## Screens

* Login Screen
* Sign Up Screen
* Task Dashboard
* Add Task Dialog
* Edit Task Dialog

---

## Getting Started

### 1 Clone the repository

```
git clone https://github.com/YOUR_GITHUB_USERNAME/To-Do-List-App.git
```

### 2 Navigate to project directory

```
cd To-Do-List-App
```

### 3 Install dependencies

```
flutter pub get
```

### 4 Run the app

```
flutter run
```

---

## Author

**Kirti Nishad**

Flutter Developer with experience in building cross-platform mobile applications using modern architectures and state management solutions.

---

## License

This project is open source and available under the MIT License.
